################################################################
# preset
################################################################
#close all
clear;
clc;
loadHK2Index();

################################################################
# setting
################################################################
# folder value example:
#   folder='.';
#   folder='./hk';

folder='./hk2';
value_lineChar='-';
plot_mode=2;

plot_c_index = [];

if plot_mode==0

plot_c_index = [
index_torqDutyCycle1,
index_torqDutyCycle2,
index_torqDutyCycle3,
];

elseif plot_mode==1

plot_c_index = [
index_torqDutyCycle1,
index_torqDutyCycle2,
index_torqDutyCycle3,
];

elseif plot_mode==2

plot_c_index = [
index_torqDutyCycle1,
index_torqDutyCycle2,
index_torqDutyCycle3,
];

end




################################################################
# file read
################################################################

data = loadHKfile(folder);

plot_header = {};

for i=1:length(plot_c_index)
    plot_header(i, :) = hk2_header(plot_c_index(i), :);
    #printf("plot_header %d :  %s\n", i, hk2_header(plot_c_index(i), :));
end

################################################################
# 중복 utc 제거
################################################################
data=sortrows(data, index_timeUtc);

utc_mat=data(:,index_timeUtc);

rm_mat=getDuplicateIndex(utc_mat);

for i=1:length(rm_mat)
    data(rm_mat(i), :) = [];
end


################################################################
# plot
################################################################
figure;

# Color
# G, B, R
# 0, 1, 1
#

#data(:,index_timeUtc), data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0], '-',
value_lineWidth=1;
#value_lineChar='-';

for plot_index=1:length(plot_c_index)
    hold on;
    #plot(data(:,index_timeUtc), data(:,plot_c_index(plot_index)), 'LineWidth', value_lineWidth, value_lineChar)
    plot([1:size(data)(1)], data(:,plot_c_index(plot_index)), 'LineWidth', value_lineWidth, value_lineChar)
end

ylim([-70 70]);
#xlim([1699753627 1699910080]);

ylabel('Temperature [degC]');
title('Temperature Trend', 'FontSize', 14);
xlabel('Time');

legend(plot_header, 'Location', 'eastoutside');


