#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@file: test_filter.py
@brief: 一阶低通滤波Python版测试用例
@author: ptmicky
@version: 1.0
@date: 2026-03-12
"""

from first_order_filter import first_order_filter
import numpy as np

def test_filter():
    # 模拟含噪声数据
    raw_data = [20, 25, 18, 22, 21, 24, 19, 23]
    k = 0.8
    last_y = raw_data[0]
    
    # 批量滤波
    filtered_data, last_y = first_order_filter(raw_data, last_y, k)
    
    # 输出结果
    print("=== Python版一阶低通滤波测试结果 ===")
    print(f"原始数据：{raw_data}")
    print(f"滤波后数据（k={k}）：{[round(y, 2) for y in filtered_data]}")

    # 可视化（可选）
    try:
        import matplotlib.pyplot as plt
        plt.figure(figsize=(8, 4))
        plt.plot(raw_data, 'ro-', label='原始数据', linewidth=1.5, markersize=6)
        plt.plot(filtered_data, 'b*-', label='滤波后数据', linewidth=1.5, markersize=6)
        plt.xlabel('采样点')
        plt.ylabel('数值')
        plt.title(f'一阶低通滤波效果（k={k}）')
        plt.grid(True)
        plt.legend()
        plt.savefig("python_filter_demo.png", dpi=100, bbox_inches='tight')
        plt.show()
    except ImportError:
        print("提示：未安装matplotlib，跳过可视化（可执行 pip install matplotlib 安装）")

if __name__ == "__main__":
    test_filter()
