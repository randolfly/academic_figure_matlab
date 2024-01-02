classdef PlotColorManager
    
    properties (Access = public)
        ColorList;
        ColorMapOrder (:,3) {mustBeReal};
    end

    properties (Constant)
        ColorDictionary = PlotColorManager.GetColorDictionary();
    end
    
    methods
        function obj = PlotColorManager()
            % specify plot color order
            obj.ColorList = [
                PlotColorManager.ColorDictionary("red");
                PlotColorManager.ColorDictionary("blue");
                PlotColorManager.ColorDictionary("green");
                PlotColorManager.ColorDictionary("yellow");
                PlotColorManager.ColorDictionary("purple");
                PlotColorManager.ColorDictionary("black");
            ];
            obj.ColorMapOrder = PlotColorManager.Hex2ColorMap(obj.ColorList);
        end
        
    end
    
    methods(Static)
        function ColorDictionary = GetColorDictionary()
                ColorDictionary = containers.Map;
%                 ColorDictionary("red") = "#FA7F6F";
%                 ColorDictionary("green") = "#8ECFC9";
%                 ColorDictionary("blue") = "#82B0D2";
%                 ColorDictionary("yellow") = "#FFBE7A";
%                 ColorDictionary("purple") = "#BEB8DC";
%                 ColorDictionary("white") = "#E7DAD2";
%                 ColorDictionary("black") = "#999999";
                ColorDictionary("red") = "#D8383A";
                ColorDictionary("blue") = "#2F7FC1";
                ColorDictionary("green") = "#96C37D";
                ColorDictionary("yellow") = "#F3D266";
                ColorDictionary("purple") = "#C497B2";
                ColorDictionary("white") = "#F8F3F9";
                ColorDictionary("black") = "#999999";
        end

        function rgbValues = Hex2ColorMap(hexCodes)
            % Remove '#' from hex codes
            hexCodes = replace(hexCodes, '#', '');
            rgbValues = zeros(length(hexCodes), 3);
            
            for id = 1:length(hexCodes)
                hexCode = char(hexCodes(id));
                rgbValues(id, 1) = hex2dec(hexCode(1:2)) / 255.0;
                rgbValues(id, 2) = hex2dec(hexCode(3:4)) / 255.0;
                rgbValues(id, 3) = hex2dec(hexCode(5:6)) / 255.0;
            end
        end
    end
    
end