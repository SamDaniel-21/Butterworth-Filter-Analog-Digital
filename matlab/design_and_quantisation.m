clc, clear, close all;

fs = 500;
T = 1/fs;
wc = 284;

pre_warp_wc = (2/T)*tan(wc*T/2);%pre warping

[b_s,a_s] = butter(3,pre_warp_wc,"s");

[b_z, a_z] = bilinear(b_s, a_s, fs);

% freqz(b_z, a_z,2048, fs)
% grid on
% title("Freq response")
disp(b_z);
disp(a_z);

r = roots(a_z);
DC_gain = sum(b_z)/sum(a_z);

check = abs(r) < 1;

%disp(check);

if all(check) && (round(DC_gain) == 1)
    fprintf("The given bilinear is valid");
    fprintf("\n DC_gain = %d\n",DC_gain);
else
    fprintf("It is invalid");
end

[sos , g] = tf2sos(b_z,a_z);
fprintf("SOS1\n");
disp(sos(1,:));
fprintf("SOS2\n");
disp(sos(2,:));
disp("g = "+g);

% fixed point arithmetic -> Quantisation
Q = 14;
sos_q = round(sos*(2^Q));
g_q = round(g*(2^Q));
fprintf("SOS after quantisation = \n");
%fprintf(sos_q);
fprintf("\n Gain after quantisation = %d", g_q);

% fvtool(dfilt.df2sos(sos_q/2^Q, g_q/2^Q))

