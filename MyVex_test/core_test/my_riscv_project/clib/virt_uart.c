#include "virt_uart.h"
#define UART_BASE 0x10000000

void uart_putc(char c) {
    *(volatile char *)UART_BASE = c;
}

void uart_puts(const char *str) {
    while (*str) {
        uart_putc(*str++);
    }
}