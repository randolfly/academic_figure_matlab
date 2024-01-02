%%
% Author       : randolf
% Date         : 2023-04-10 14:36:44
% LastEditors  : randolf
% LastEditTime : 2023-04-10 15:19:59
% FilePath     : \academic_figure_matlab\model\@BaseFigureConfig\BaseFigureConfig.m
%%
classdef BaseFigureConfig < handle
    properties
        FontSize {mustBeInteger} = 12;  % unit: pt
        % defacult chinese: Song; english: Arial
        FontFamily {mustBeNonzeroLengthText} = 'Arial';
        
        % single figure with
        SingleFigureWidth {mustBeReal} = 8.4;   % unit: cm, modified by method, do not recommend user to modify
        % all figure height, contains all subplot
        HeightWidthRatio {mustBeReal} = 0.75;   % unit: ratio
        Resolution {mustBeInteger} = 600;   % unit: DPI
        LineWidth {mustBeReal} = 1.5;   % linewidth
    end
    
    properties (Access = private, Constant)
        ConfigFolderPath {mustBeText} = BaseFigureConfig.GetConfigPath();
        DefaultConfig {mustBeText} = "springer_sample_conifg.json";
    end
    
    methods(Static, Access=private)
        function config_path = GetConfigPath()
            file_path = which('APlot');
            split_file_path_list = split(file_path, '\');
            config_path = split_file_path_list(1);
            for i = 2:(length(split_file_path_list)-3)
                config_path = fullfile(config_path, split_file_path_list(i));
            end
            config_path = fullfile(config_path, "config");
        end
    end
    
    
    methods(Static)
        function figureConfig = UILoadFigureConfig(folderPath)
            %myFun - Description
            % open a window to choose json conifg file
            %
            % Syntax: figureConfig = loadFigureConfig(folderPath)
            arguments
                folderPath {mustBeNonzeroLengthText} = BaseFigureConfig.ConfigFolderPath;
            end
            [file, path] = uigetfile('*.json', 'defname', folderPath, 'MultiSelect', 'off');
            if isequal(file, 0)
                disp('User selected Cancel');
                ME = MException('loadFigureConfig:User selected Cancel');
                throw(ME)
            else
                figureConfig = BaseFigureConfig.LoadFigureConfig(string(file), string(path));
            end
        end
        
        function figureConfig = LoadFigureConfig(fileName, filePath)
            arguments
                fileName {mustBeNonzeroLengthText} = BaseFigureConfig.DefaultConfig;
                filePath {mustBeNonzeroLengthText} = BaseFigureConfig.ConfigFolderPath;
            end
            %myFun - extract json by given file path
            %
            % Syntax: figureConfig = LoadFigureConfig(filePath)
            %
            % Long description
            figureConfigText = join(readlines(fullfile(filePath,fileName)));
            figureConfigStruct = jsondecode(figureConfigText);
            figureConfig = BaseFigureConfig();
            figureConfig.setFigureConifg(figureConfigStruct);
        end
    end
    
    methods
        function obj = BaseFigureConfig()
            
        end
        
        function setFigureConifg(obj, figureConfig)
            arguments
                obj
                figureConfig % TODO validate struct
            end
            obj.FontSize = figureConfig.FontSize;
            obj.FontFamily = figureConfig.FontFamily;
            obj.SingleFigureWidth = figureConfig.SingleFigureWidth;
            obj.HeightWidthRatio = figureConfig.HeightWidthRatio;
            obj.Resolution = figureConfig.Resolution;
            obj.LineWidth = figureConfig.LineWidth;
        end
    end
end

