% TEST_FILTER 一阶低通滤波函数测试脚本
% 功能：验证firstOrderLowpassFilter.m的正确性，输出原始数据与滤波结果对比

clear; clc; close all;

%% 1. 模拟含噪声的原始数据
raw_data = [20,25,18,22,21,24,19,23]; % 传感器模拟数据
k = 0.8; % 滤波系数（可调整测试不同效果）
last_y = raw_data(1); % 初始化滤波历史值

%% 2. 批量滤波处理
filtered_data = zeros(size(raw_data));
for i = 1:length(raw_data)
    [filtered_data(i), last_y] = firstOrderLowpassFilter(raw_data(i), k, last_y);
end

%% 3. 结果输出与可视化
fprintf('=== 一阶低通滤波测试结果 ===\n');
fprintf('原始数据：%s\n', num2str(raw_data));
fprintf('滤波后数据（k=%.1f）：%s\n', k, num2str(round(filtered_data, 2)));

% 绘图对比
figure('Color','white');
plot(raw_data, 'ro-', 'LineWidth',1.5, 'MarkerSize',6, 'DisplayName','原始数据');
hold on;
plot(filtered_data, 'b*-', 'LineWidth',1.5, 'MarkerSize',6, 'DisplayName','滤波后数据');
xlabel('采样点');
ylabel('数值');
title(sprintf('一阶低通滤波效果对比（k=%.1f）', k));
grid on;
legend('Location','best');
