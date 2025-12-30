clc, clearvars, close all;

data = readmatrix("D:\verilog-projects\IIR_filter\project_1.sim\sim_1\behav\xsim\IIR_data.csv");
disp(size(data));
x_n = data(:,1)/2^14;
y_n = data(:,2)/2^14;

plot(x_n);
hold on;
plot(y_n);
grid on
legend("x[n]","y[n]");