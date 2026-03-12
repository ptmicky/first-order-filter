function [current_y, filter_history] = firstOrderLowpassFilter(x, k, filter_history)
% FIRSTORDERLOWPASSFILTER 一阶低通滤波（指数移动平均滤波）实现
% 函数功能：对输入的原始信号进行一阶低通滤波，平滑噪声，保留低频趋势
% 公式：y = k·y_prev + (1-k)·x （y_prev为上一次滤波输出，x为当前输入）
% 
% 输入参数：
%   x           - 数值/数组，当前输入值（原始采集数据，如传感器读数）
%   k           - 标量，滤波系数（0≤k≤1），k越大滤波越强、响应越慢；k越小响应越快、滤波越弱
%   filter_history - 标量，上一次的滤波输出值（初始化时建议用第一个原始数据）
% 
% 输出参数：
%   current_y   - 数值/数组，当前滤波输出值
%   filter_history - 标量，更新后的滤波历史值（供下一次迭代使用）
% 
% 异常处理：
%   1. 滤波系数k超出[0,1]范围时，抛出警告并强制限定在合法区间
%   2. 输入x非数值类型时，抛出错误
% 
% 使用示例：
%   % 单值滤波（单次调用）
%   last_y = 20;          % 初始化历史值
%   [y, last_y] = firstOrderLowpassFilter(25, 0.8, last_y);
% 
%   % 数组滤波（批量处理）
%   raw_data = [20,25,18,22,21,24,19,23];  % 含噪声的原始数据
%   k = 0.8;                               % 滤波系数
%   last_y = raw_data(1);                  % 初始化历史值
%   filtered_data = zeros(size(raw_data)); % 预分配内存
%   for i = 1:length(raw_data)
%       [filtered_data(i), last_y] = firstOrderLowpassFilter(raw_data(i), k, last_y);
%   end
% 
% 作者：ptmicky
% 版本：1.0
% 日期：2026-03-12
% GitHub仓库：https://github.com/ptmicky/first-order-filter

%% 输入参数校验
% 校验k的范围
if k < 0 || k > 1
    warning('滤波系数k超出[0,1]范围，已自动限定为%s边界值', k<0 ? '0' : '1');
    k = max(0, min(k, 1)); % 强制限定k在[0,1]
end

% 校验x是否为数值类型
if ~isnumeric(x)
    error('输入值x必须为数值类型（标量/数组），当前输入类型：%s', class(x));
end

% 校验filter_history是否为标量数值
if ~isnumeric(filter_history) || ~isscalar(filter_history)
    error('滤波历史值filter_history必须为标量数值，当前输入：%s', class(filter_history));
end

%% 核心滤波计算
if isscalar(x)
    % 单值输入：直接计算
    current_y = k * filter_history + (1 - k) * x;
else
    % 数组输入：逐元素迭代滤波（保留历史值连续更新）
    current_y = zeros(size(x));
    temp_history = filter_history; % 临时保存历史值，避免修改原始输入
    for i = 1:length(x)
        current_y(i) = k * temp_history + (1 - k) * x(i);
        temp_history = current_y(i); % 更新历史值
    end
    filter_history = temp_history; % 输出最终历史值
end

%% 输出格式规整（确保为数值标量/数组）
current_y = double(current_y);
filter_history = double(filter_history);

end
