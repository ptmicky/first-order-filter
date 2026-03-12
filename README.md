# 一阶低通滤波（指数移动平均滤波）多语言实现
基于公式 `y = k·y_prev + (1-k)·x` 的一阶低通滤波算法，提供C/Python/MATLAB三种语言实现，适用于传感器数据平滑、实时信号去噪、时序数据处理等场景。

## 核心特性
✅ 轻量级：无第三方库依赖（Python可视化可选matplotlib）；
✅ 鲁棒性：完善的参数校验，自动修正非法滤波系数；
✅ 灵活性：支持单值实时滤波、数组批量滤波；
✅ 易移植：跨语言逻辑统一，可直接集成到嵌入式/数据分析项目；
✅ 低内存：仅保存上一次滤波值，无需缓存历史数据。

## 快速使用
### C语言版本
```c
#include "first_order_filter.h"

// 初始化
float raw_data[] = {20,25,18,22,21,24,19,23};
float filtered_data[8] = {0};
float last_y = raw_data[0];
float k = 0.8;

// 批量滤波
batch_filter(raw_data, filtered_data, 8, k, &last_y);
