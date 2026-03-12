/**
 * @file first_order_filter.c
 * @brief 一阶低通滤波核心实现
 * @author ptmicky
 * @version 1.0
 * @date 2026-03-12
 * @license MIT License
 */

#include "first_order_filter.h"
#include <stdio.h>

/**
 * @brief 一阶低通滤波（单值）
 */
float first_order_filter(float x, float *last_y, float k)
{
    // 输入校验：k限定在[0,1]
    if (k < 0.0f) k = 0.0f;
    if (k > 1.0f) k = 1.0f;
    
    // 空指针保护
    if (last_y == NULL) {
        printf("Error: last_y is NULL!\n");
        return x;
    }

    // 核心滤波计算
    float current_y = k * (*last_y) + (1 - k) * x;
    *last_y = current_y; // 更新历史值
    return current_y;
}

/**
 * @brief 批量数组滤波
 */
void batch_filter(float *raw_data, float *filtered_data, uint16_t length, float k, float *last_y)
{
    if (raw_data == NULL || filtered_data == NULL || last_y == NULL) {
        printf("Error: input array is NULL!\n");
        return;
    }
    if (length == 0) {
        printf("Error: array length is 0!\n");
        return;
    }

    // 逐元素滤波
    for (uint16_t i = 0; i < length; i++) {
        filtered_data[i] = first_order_filter(raw_data[i], last_y, k);
    }
}
