import serial
import time
import matplotlib.pyplot as plt
from matplotlib.widgets import TextBox, Button

# ==========================================
# CONFIGURATION
# ==========================================
PORT = 'COM3'  # CHANGE THIS to your PYNQ-Z2 COM port!
BAUDRATE = 115200

# Connect to PYNQ-Z2
try:
    ser = serial.Serial(PORT, BAUDRATE, timeout=0.1)
    print(f"Connected to {PORT} successfully!")
except Exception as e:
    print(f"Error opening {PORT}: {e}")
    print("Please change the PORT variable at the top of the script!")
    exit(1)

# ==========================================
# SETUP PLOT
# ==========================================
fig, ax = plt.subplots(figsize=(8, 7))
plt.subplots_adjust(bottom=0.25) # Make room for UI at the bottom
fig.canvas.manager.set_window_title('PYNQ-Z2 Real-Time Alignment Target')

# Assuming 24-bit signed ADC range approx (+/- 8,388,608)
ax.set_xlim(-8388608, 8388607)
ax.set_ylim(-8388608, 8388607)
ax.axhline(0, color='black', linestyle='--')
ax.axvline(0, color='black', linestyle='--')
ax.set_xlabel('X Position (ADC 1)')
ax.set_ylabel('Y Position (ADC 2)')
ax.set_title('Thorlabs-Style Beam Tracker')
ax.grid(True)

# The red crosshair dot
point, = ax.plot([0], [0], 'r+', markersize=15, markeredgewidth=2)

# ==========================================
# SETUP UI BUTTONS & TEXTBOXES
# ==========================================
axbox_x = plt.axes([0.2, 0.1, 0.2, 0.075])
text_x = TextBox(axbox_x, 'X Voltage: ', initial="0.0")

axbox_y = plt.axes([0.6, 0.1, 0.2, 0.075])
text_y = TextBox(axbox_y, 'Y Voltage: ', initial="0.0")

ax_button = plt.axes([0.4, 0.02, 0.2, 0.075])
btn = Button(ax_button, 'Send to PYNQ', hovercolor='0.975')

def submit(event):
    try:
        vx = float(text_x.text)
        vy = float(text_y.text)
        # Send strings to the Vitis C application
        ser.write(f"SET_X {vx}\n".encode('utf-8'))
        ser.write(f"SET_Y {vy}\n".encode('utf-8'))
        print(f"Command Sent: X = {vx}V, Y = {vy}V")
    except ValueError:
        print("Error: Invalid voltage input!")

btn.on_clicked(submit)

# ==========================================
# MAIN LOOP (Polling & Plotting)
# ==========================================
print("Live Plot running. Close the window to stop.")

# This loop constantly asks the PYNQ for data and updates the graph
while plt.fignum_exists(fig.number):
    try:
        # Request position
        ser.write(b"GET_POS\n")
        
        # Read response
        line = ser.readline().decode('utf-8').strip()
        if line.startswith("POS"):
            parts = line.split(" ")
            if len(parts) == 3:
                x_val = float(parts[1])
                y_val = float(parts[2])
                # Print the received X and Y values to the terminal
                print(f"X: {x_val}, Y: {y_val}")
                # Update the crosshair position
                point.set_xdata([x_val])
                point.set_ydata([y_val])
                fig.canvas.draw_idle()
    except Exception as e:
        # Ignore minor serial timeouts
        pass
    
    # Pause lets the GUI update and process button clicks (approx 20 FPS)
    plt.pause(0.05) 

ser.close()
print("Disconnected.")
