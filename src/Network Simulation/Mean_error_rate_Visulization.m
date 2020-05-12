function [] = Mean_error_rate_Visulization()
% Illustrate the definition of mean error rate

    path = [pwd, '\Network\Mean error rate\'];
    if ~exist(path) mkdir(path); end

    figure
    x=linspace(0, 1, 101);
    y = 1 ./ (1 + exp(-10 .* (x-0.5)));
    hold on

    dense = 0.95;
    X=[x(1, 1:51), 0.5, 0];
    Y=[y(1, 1:51), 0, 0];
    fill(X,Y, [dense, dense, dense]);

    X=[x(1, 51:101), 1, 0.5];
    Y=[y(1, 51:101), 1, 1];
    h1 = fill(X,Y, [dense, dense, dense]);

    h2 = plot(x, y, 'Color', [1 0 0], 'linewidth', 1);

    h3 = plot([0, 0.5, 0.5, 1], [0, 0, 1, 1], 'Color', [0 0 1], 'linewidth', 1);

    h=[h2, h3, h1];
    legend(h, ['��������', sprintf('\n'), 'Practical Result Curve'], ...
        ['����ľ�������', sprintf('\n'), 'Ideal Result Curve'], ...
        ['ƽ�������', sprintf('\n'), 'Mean Error Rate'], 'Location', 'best');

    % grid on
    % set(gca, 'GridLineStyle', ':');
    % set(gca, 'GridAlpha', 1); 
    xlabel({'�˶�ǿ��'; 'Motion Strength'});
    ylabel({'���߽��Ϊ���ϵĸ���'; 'Upward preference'});


    hold off

    saveas(gcf, [path, 'mean error rate.jpg']);
    close all
end