#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@file: first_order_filter.py
@brief: 一阶低通滤波（指数移动平均滤波）Python实现
@author: ptmicky
@version: 1.0
@date: 2026-03-12
@license: MIT License

核心公式：y = k * last_y + (1 - k) * x
适用场景：传感器数据平滑、时序数据去噪、实时数据处理
特性：
- 支持单值/数组输入
- 完善的参数校验
- 低内存占用（仅保存上一次滤波值）
"""

def first_order_filter(x, last_y, k=0.8):
    """
    一阶低通滤波核心函数
    
    Parameters:
        x (float/list/numpy.ndarray): 当前输入值（原始采集数据）
        last_y (float): 上一次的滤波输出值（初始化用第一个原始值）
        k (float): 滤波系数（0≤k≤1），默认0.8
    
    Returns:
        current_y (float/list/numpy.ndarray): 当前滤波输出值
        new_last_y (float): 更新后的滤波历史值
    
    Raises:
        TypeError: 输入类型非数值/数组
        ValueError: 滤波系数超出[0,1]范围（仅警告，自动修正）
    """
    # 输入校验：滤波系数k
    if not isinstance(k, (int, float)):
        raise TypeError(f"滤波系数k必须为数值类型，当前类型：{type(k)}")
    if k < 0 or k > 1:
        import warnings
        warnings.warn(f"滤波系数k={k}超出[0,1]范围，已自动修正为{max(0, min(k, 1))}")
        k = max(0, min(k, 1))
    
    # 输入校验：last_y
    if not isinstance(last_y, (int, float)):
        raise TypeError(f"历史值last_y必须为数值类型，当前类型：{type(last_y)}")
    
    # 单值输入
    if isinstance(x, (int, float)):
        current_y = k * last_y + (1 - k) * x
        new_last_y = current_y
        return current_y, new_last_y
    
    # 数组输入（list/numpy.ndarray）
    elif isinstance(x, (list,)) or (hasattr(x, '__iter__') and not isinstance(x, (str, dict))):
        import numpy as np
        x = np.array(x, dtype=np.float64)
        current_y = np.zeros_like(x)
        temp_last_y = last_y
        
        for i in range(len(x)):
            current_y[i] = k * temp_last_y + (1 - k) * x[i]
            temp_last_y = current_y[i]
        
        # 适配返回类型（输入list则返回list，否则返回ndarray）
        if isinstance(x, list):
            current_y = current_y.tolist()
        new_last_y = float(temp_last_y)
        return current_y, new_last_y
    
    # 非法输入
    else:
        raise TypeError(f"输入x必须为数值/数组，当前类型：{type(x)}")

# 方便脚本直接运行
if __name__ == "__main__":
    import sys
    sys.exit(0)
