function aplot_fig_2x1()
    disp("================== 2x1 single line figure ==================")
    x = 0:0.1:10;
    y1 = sin(x);
    y2 = cos(x);

    % Initialize a figure with 1x1 subplots
    ap = APlot(2, 1);
    ap.ASubPlot(1);

    plot(x, y1);
    xlabel("time")
    ylabel("sin");

    ap.ASubPlot(2);

    plot(x, y2);
    xlabel("time")
    ylabel("cos");

    ap.ExportFigure("2x1_single_line", "./", false);

    disp("================== 2x1 single line figure (changed figure config) ==================")
    x = 0:0.1:10;
    y1 = sin(x);
    y2 = cos(x);

    % Initialize a figure with 1x1 subplots
    % select config by ui choosen, also can use BaseFigureConfig.LoadFigureConfig(file_name, file_path);
    ap_config = BaseFigureConfig.UILoadFigureConfig();

    ap = APlot(2, 1, ap_config);
    ap.ASubPlot(1);

    plot(x, y1);
    xlabel("time")
    ylabel("sin");

    ap.ASubPlot(2);

    plot(x, y2);
    xlabel("time")
    ylabel("cos");

    % export figure in publication standard: pdf, jpg, eps
    ap.ExportFigure("2x1_single_line_with_config", "./", true);
end
