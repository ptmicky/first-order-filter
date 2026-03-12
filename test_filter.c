/**
 * @file test_filter.c
 * @brief 一阶低通滤波测试用例
 * @author ptmicky
 * @version 1.0
 * @date 2026-03-12
 */

#include "first_order_filter.h"
#include <stdio.h>

int main(void)
{
    // 模拟含噪声的传感器数据
    float raw_data[] = {20.0f, 25.0f, 18.0f, 22.0f, 21.0f, 24.0f, 19.0f, 23.0f};
    uint16_t length = sizeof(raw_data) / sizeof(raw_data[0]);
    float filtered_data[length] = {0}; // 滤波结果数组
    float k = 0.8f; // 滤波系数
    float last_y = raw_data[0]; // 初始化历史值

    // 批量滤波
    batch_filter(raw_data, filtered_data, length, k, &last_y);

    // 输出结果
    printf("=== C版一阶低通滤波测试结果 ===\n");
    printf("原始数据：");
    for (uint16_t i = 0; i < length; i++) {
        printf("%.1f ", raw_data[i]);
    }
    printf("\n滤波后数据（k=%.1f）：", k);
    for (uint16_t i = 0; i < length; i++) {
        printf("%.2f ", filtered_data[i]);
    }
    printf("\n");

    return 0;
}
