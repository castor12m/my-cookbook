################################################################
# preset
################################################################
#close all
clear;
clc;
loadHK1Index();

################################################################
# setting
################################################################
# folder value example:
#   folder='.';
#   folder='./hk';

folder='./hk';
value_lineChar='-';
plot_c_index = [
    index_obcTemp,
    #index_spStationTempXp,
    #index_spStationTempXn,
    #index_spStationTempYn,
    #index_spStationTempYp,
    #index_spUpTopTempXp,
    #index_spUpTopTempXn,
    #index_spUpTopTempYn,
    #index_spUpBotTempXp,
    #index_spUpBotTempXn,
    #index_spUpBotTempYn,
    index_adcPdhsCaseTemp,
    index_adcEwc27CaseTemp,
    index_dockTemp1,
    #index_dockTemp2,
    index_pduTemp,
    index_acuTemp1,
    #index_acuTemp2,
    #index_acuTemp3,
    index_battery1Temp1,
    #index_battery1Temp2,
    #index_battery1Temp3,
    #index_battery1Temp4,
    index_battery2Temp1,
    #index_battery2Temp2,
    #index_battery2Temp3,
    #index_battery2Temp4,
    index_sBandBoardTemp
    #index_sBandPaTemp
];


################################################################
# file read
################################################################

data = loadHKfile(folder);

plot_header = {};

for i=1:length(plot_c_index)
    plot_header(i, :) = hk_header(plot_c_index(i), :);
    #printf("plot_header %d :  %s\n", i, hk_header(plot_c_index(i), :));
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


