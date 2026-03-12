/**
 * @file first_order_filter.h
 * @brief 一阶低通滤波（指数移动平均滤波）头文件
 * @author ptmicky
 * @version 1.0
 * @date 2026-03-12
 * @license MIT License
 * 
 * 核心公式：y = k * last_y + (1 - k) * x
 * 适用场景：嵌入式传感器数据平滑、实时信号去噪（温度/湿度/电压等）
 */

#ifndef FIRST_ORDER_FILTER_H
#define FIRST_ORDER_FILTER_H

#include <stdint.h>
#include <stdbool.h>

/**
 * @brief 一阶低通滤波函数（单值实时滤波）
 * @param x 当前输入值（原始采集数据）
 * @param last_y 指针：上一次的滤波输出值（需初始化，建议用第一个原始值）
 * @param k 滤波系数（0≤k≤1），k越大滤波越强、响应越慢
 * @return 当前滤波输出值
 */
float first_order_filter(float x, float *last_y, float k);

/**
 * @brief 批量数组滤波（适配多组传感器数据）
 * @param raw_data 原始数据数组
 * @param filtered_data 输出：滤波后数据数组（需提前分配内存）
 * @param length 数组长度
 * @param k 滤波系数
 * @param last_y 指针：初始滤波历史值
 */
void batch_filter(float *raw_data, float *filtered_data, uint16_t length, float k, float *last_y);

#endif // FIRST_ORDER_FILTER_H
