function Results_plot_Sensitivity()
% Merge the mean error rate curves together.

    path = [pwd, '\Results\Sensitivity\'];
    front = [path, 'Mean error rate '];

    f1=openfig([front, 'A multimodal', '.fig'],'reuse');
    % f2=openfig([front, 'V multimodal', '.fig'],'reuse');
    f3=openfig([front, 'A unimodal', '.fig'],'reuse');
    % f4=openfig([front, 'V unimodal', '.fig'],'reuse');

    x=get(findall(f1, 'type', 'line'),'xdata');
    y1=get(findall(f1, 'type', 'line'),'ydata');
    % y2=get(findall(f2, 'type', 'line'),'ydata');
    y3=get(findall(f3, 'type', 'line'),'ydata');
    % y4=get(findall(f4, 'type', 'line'),'ydata');

    figure
    plot(x, y1);
    hold on
    %plot(x, y2);
    plot(x, y3);
    %plot(x, y4);
    hold off
    xlabel({'���������ȵȼ�'; 'Decision Sensitivity Level'});
    ylabel({'ƽ�������'; 'Mean Error Rate'});
    xlim([min(x) max(x)]);
    %ylim([0.059, 0.072]);
    %legend('��ģ̬�Ӿ�����', '��ģ̬��������', '��ģ̬�Ӿ�����', '��ģ̬��������');
    legend(['��ģ̬�Ӿ�����', sprintf('\n'), 'Cross-modal Visual Tasks'], ['��ģ̬�Ӿ�����', sprintf('\n'), 'Unimodal Visual Tasks']);
    saveas(gcf, [path, 'mean error rate merge.jpg']);  

    close all;

end