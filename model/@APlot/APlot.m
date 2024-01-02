%%
% Author       : randolf
% Date         : 2023-04-10 16:11:59
% LastEditors  : randolf
% LastEditTime : 2023-04-10 19:22:16
% FilePath     : \undefinede:\Code\Matlab\ToolCodes\academic_figure_matlab\model\@APlot\APlot.m
%%

classdef APlot < handle

    properties (Access = public)
        FigureConfig BaseFigureConfig
        FigRowNum {mustBeInteger} = 1; % num of axes horizontally
        FigColNum {mustBeInteger} = 1; % num of axes vertically
        PlotType char {mustBeMember(PlotType, {'tight', 'compact', 'loose'})} = 'tight';
        ColorManager PlotColorManager = PlotColorManager();
        AxesDict containers.Map; % axes dict object
    end

    properties (Access = private)
        Figure % plot figure instance
        FigWidth {mustBeReal}; % calculated figure
        FigHeight {mustBeReal}; % calculated figure

    end

    methods

        function obj = APlot(figRowNum, figColNum, figureConfig, plotType)

            arguments
                figRowNum {mustBeInteger} = 1; % num of axes horizontally
                figColNum {mustBeInteger} = 1; % num of axes vertically
                figureConfig BaseFigureConfig = BaseFigureConfig.LoadFigureConfig(); % default config
                plotType char {mustBeMember(plotType, {'tight', 'compact', 'loose'})} = 'tight';
            end

            % Init Figure Config
            obj.FigureConfig = figureConfig;
            obj.FigRowNum = figRowNum;
            obj.FigColNum = figColNum;
            obj.PlotType = plotType;

            obj.AxesDict = containers.Map();
            % update figure size
            obj.CalculateFigureSize();
            % update figure style
            obj.SetFigureStyle();
        end

        function SetFigureStyle(obj)
            set(groot, 'defaultAxesFontName', obj.FigureConfig.FontFamily);
            set(groot, 'defaultTextFontName', obj.FigureConfig.FontFamily);
            set(groot, 'defaultAxesFontSize', obj.FigureConfig.FontSize);
            set(groot, 'defaultTextFontSize', obj.FigureConfig.FontSize);
            set(groot, 'DefaultLineLineWidth', obj.FigureConfig.LineWidth);
            set(groot, 'defaultAxesColorOrder', obj.ColorManager.ColorMapOrder);

            % always grid on
            set(groot, 'defaultAxesXGrid', 'on')
            set(groot, 'defaultAxesYGrid', 'on')
            obj.Figure = figure('PaperUnits', 'centimeters', ...
                'PaperSize', [obj.FigWidth, obj.FigHeight], ...
                'Renderer', 'painters', ...
                'PaperPositionMode', 'manual', ...
                'PaperPosition', [0, 0, obj.FigWidth, obj.FigHeight]);
        end

        function CalculateFigureSize(obj)
            obj.FigWidth = obj.FigColNum * obj.FigureConfig.SingleFigureWidth;
            obj.FigHeight = obj.FigRowNum * obj.FigureConfig.SingleFigureWidth * obj.FigureConfig.HeightWidthRatio;
        end

        function ExportFigure(obj, figureName, figurePath, isPublication)

            arguments
                obj
                figureName string {mustBeNonzeroLengthText}
                figurePath string {mustBeNonzeroLengthText} = "D:\tmp\desktop\tmp"
                isPublication = false % true: Automatically Export jpg and eps
            end

            time = string(datetime('now', 'TimeZone', 'Asia/Seoul', 'Format', 'yyyyMMdd'));
            fileName = figureName + "_" + time;

            if isPublication
                % dirPdfPath = fullfile(figurePath, 'pdf');
                dirJpgPath = fullfile(figurePath, 'jpg');
                dirEpsPath = fullfile(figurePath, 'eps');

                % filePdfPath = checkExportDirExist(dirPdfPath, fileName);
                fileJpgPath = checkExportDirExist(dirJpgPath, fileName);
                fileEpsPath = checkExportDirExist(dirEpsPath, fileName);

                % print(filePdfPath, '-dpdf');
                print(fileJpgPath, '-djpeg', '-r600');
                print(fileEpsPath, '-depsc2', '-r600');
            else
                dirJpgPath = fullfile(figurePath, 'jpg');
                fileJpgPath = checkExportDirExist(dirJpgPath, fileName);
                print(fileJpgPath, '-djpeg', '-r600');
            end

            disp("Exported figure successfully!");

        end

        function ax = ASubPlot(obj, ind)
            % PLOT a tight figure
            % 函数的基本使用形式为:

            % REF: https://zhuanlan.zhihu.com/p/567567919
            % @author : slandarer
            % 公众号  : slandarer随笔
            % 知乎    : hikari

            key_id = 0;

            for id = 1:length(ind)
                key_id = 10 ^ (id - 1) * ind(id) + key_id;
            end

            if isKey(obj.AxesDict, string(key_id))
                ax = obj.AxesDict(string(key_id));
            else
                sz = [obj.FigRowNum, obj.FigColNum];
                ratio1 = [0, 0, 1, 1];

                switch obj.PlotType
                    case 'tight'
                        ratio1 = [0, 0, 1, 1];
                        % ratio2=[0.031 0.054 0.9619 0.9254];
                    case 'compact'
                        ratio1 = [0.034 0.0127 0.9256 0.9704];
                        % ratio2=[0.065 0.0667 0.8875 0.8958];
                    case 'loose'
                        ratio1 = [0.099 0.056 0.8131 0.8896];
                        % ratio2=[0.13 0.11 0.775 0.815];
                end

                k = 1;
                posList = zeros(sz(1) * sz(2), 4);

                for i = 1:sz(1)

                    for j = 1:sz(2)
                        tpos = [(j - 1) / sz(2), (sz(1) - i) / sz(1), 1 / sz(2), 1 / sz(1)];
                        posList(k, :) = [tpos(1) + tpos(3) .* ratio1(1), tpos(2) + tpos(4) .* ratio1(2), ...
                                             tpos(3) .* ratio1(3), tpos(4) .* ratio1(4)];
                        k = k + 1;
                    end

                end

                posSet = posList(ind(:), :);
                xmin = min(posSet(:, 1));
                ymin = min(posSet(:, 2));
                xmax = max(posSet(:, 1) + posSet(:, 3));
                ymax = max(posSet(:, 2) + posSet(:, 4));
                %             ax=axes('Parent',gcf,'LooseInset',[0,0,0,0],...
                %                 'OuterPosition',[xmin,ymin,xmax-xmin,ymax-ymin], ...
                %                 'FontSize',12, 'FontName', 'Arial');
                ax = axes('Parent', obj.Figure, 'LooseInset', [0, 0, 0, 0], ...
                    'OuterPosition', [xmin, ymin, xmax - xmin, ymax - ymin]);
                obj.AxesDict(string(key_id)) = ax;
            end

        end

    end

end

function filePath = checkExportDirExist(dirPath, fileName)

    if ~exist(dirPath, 'dir')
        mkdir(dirPath);
    end

    filePath = fullfile(dirPath, fileName);
end
