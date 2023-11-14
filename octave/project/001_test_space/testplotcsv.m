# folder value example:
#   folder='.';
#   folder='./input';

folder='./input';

loadHK1Index();

data = loadHKfile(folder);

figure;

# Color
# G, B, R
# 0, 1, 1
#

plot(
data(:,1), data(:,2), 'LineWidth', 2, 'Color', [0, 1, 0], '-',
data(:,1), data(:,3), 'LineWidth', 2, 'Color', [0, 0, 1], '-',
data(:,1), data(:,4), 'LineWidth', 2, 'Color', [1, 0, 0], '-'
)


ylabel('Temperature [degC]');
title('Temperature Trend');
xlabel('Time');

legend(
'test'
);000

