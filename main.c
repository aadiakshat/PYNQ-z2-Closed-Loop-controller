#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xparameters.h"

#define GPIO_0_DEVICE_ID  XPAR_XGPIO_0_BASEADDR // DAC Outputs
#define GPIO_1_DEVICE_ID  XPAR_XGPIO_1_BASEADDR // ADC Inputs

#define DAC_X_CHANNEL 1
#define DAC_Y_CHANNEL 2
#define ADC_X_CHANNEL 1
#define ADC_Y_CHANNEL 2

XGpio Gpio_DAC;
XGpio Gpio_ADC;

int main()
{
    init_platform();
    int Status;
    char buffer[64];
    int buf_idx = 0;

    // Initialize DAC GPIO (Outputs)
    Status = XGpio_Initialize(&Gpio_DAC, GPIO_0_DEVICE_ID);
    if (Status != XST_SUCCESS) return XST_FAILURE;
    XGpio_SetDataDirection(&Gpio_DAC, DAC_X_CHANNEL, 0x00000000); // Output
    XGpio_SetDataDirection(&Gpio_DAC, DAC_Y_CHANNEL, 0x00000000); // Output

    // Initialize ADC GPIO (Inputs)
    Status = XGpio_Initialize(&Gpio_ADC, GPIO_1_DEVICE_ID);
    if (Status != XST_SUCCESS) return XST_FAILURE;
    XGpio_SetDataDirection(&Gpio_ADC, ADC_X_CHANNEL, 0xFFFFFFFF); // Input
    XGpio_SetDataDirection(&Gpio_ADC, ADC_Y_CHANNEL, 0xFFFFFFFF); // Input

    xil_printf("XY_MONITOR_READY\r\n");

    while (1) {
        // Simple non-blocking UART read
        char c = inbyte(); 
        
        if (c == '\n' || c == '\r') {
            buffer[buf_idx] = '\0'; // Null-terminate string
            if (buf_idx > 0) {
                // Parse Command
                if (strncmp(buffer, "SET_X ", 6) == 0) {
                    float v = atof(&buffer[6]);
                    u16 code = (u16)((v / 2.5) * 65535.0);
                    XGpio_DiscreteWrite(&Gpio_DAC, DAC_X_CHANNEL, code);
                } 
                else if (strncmp(buffer, "SET_Y ", 6) == 0) {
                    float v = atof(&buffer[6]);
                    u16 code = (u16)((v / 2.5) * 65535.0);
                    XGpio_DiscreteWrite(&Gpio_DAC, DAC_Y_CHANNEL, code);
                } 
                else if (strncmp(buffer, "GET_POS", 7) == 0) {
                    u32 x_pos = XGpio_DiscreteRead(&Gpio_ADC, ADC_X_CHANNEL);
                    u32 y_pos = XGpio_DiscreteRead(&Gpio_ADC, ADC_Y_CHANNEL);
                    // Print back to MATLAB
                    xil_printf("POS %lu %lu\r\n", x_pos, y_pos);
                }
            }
            buf_idx = 0; // Reset buffer
        } else {
            if (buf_idx < 63) {
                buffer[buf_idx++] = c;
            }
        }
    }

    cleanup_platform();
    return 0;
}
