function aplot_fig_1x1()
    disp("================== 1x1 single line figure ==================")
    x = 0:0.1:10;
    y = sin(x);

    % Initialize a figure with 1x1 subplots
    ap = APlot(1, 1);
    ap.ASubPlot(1);

    % Figure properties are automatically set by calling APlot()
    % ASubplot is used to set subplot margins
    plot(x, y);
    xlabel("time")
    ylabel("sin");

    ap.ExportFigure("1x1_single_line", "./", false);

    disp("================== 1x1 multiple line figure ==================")
    x = 0:0.1:10;
    y1 = sin(x);
    y2 = cos(x);

    % Initialize a figure with 1x1 subplots
    ap = APlot(1, 1);
    ap.ASubPlot(1);

    plot(x, y1); hold on;
    plot(x, y2);
    xlabel("time")
    ylabel("sin");

    ap.ExportFigure("1x1_multiple_line", "./", false);
end
