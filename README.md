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


### Python 版本
from first_order_filter import first_order_filter

raw_data = [20,25,18,22,21,24,19,23]
last_y = raw_data[0]
filtered_data, last_y = first_order_filter(raw_data, last_y, k=0.8)

### MATLAB 版本
raw_data = [20,25,18,22,21,24,19,23];
last_y = raw_data(1);
filtered_data = zeros(size(raw_data));
for i = 1:length(raw_data)
    [filtered_data(i), last_y] = firstOrderLowpassFilter(raw_data(i), 0.8, last_y);
end

滤波系数 k 调优指南
场景	推荐 k 值	效果说明
静态信号（温度）	0.9~1.0	极强滤波，噪声抑制最优
普通动态信号（转速）	0.7~0.9	平衡滤波与响应速度
快速信号（加速度）	0.1~0.7	弱滤波，保证实时性
