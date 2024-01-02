classdef PlotColorManager
    
    properties (Access = public)
        ColorDictionary;
        ColorList;
        ColorMapOrder (:,3) {mustBeReal};
    end
    
    methods
        function obj = PlotColorManager()
            obj.ColorDictionary = containers.Map;
            % obj.ColorDictionary("red") = "#FA7F6F";
            % obj.ColorDictionary("green") = "#8ECFC9";
            % obj.ColorDictionary("blue") = "#82B0D2";
            % obj.ColorDictionary("yellow") = "#FFBE7A";
            % obj.ColorDictionary("purple") = "#BEB8DC";
            % obj.ColorDictionary("white") = "#E7DAD2";
            % obj.ColorDictionary("black") = "#999999";
            
            obj.ColorDictionary("red") = "#D8383A";
            obj.ColorDictionary("blue") = "#2F7FC1";
            obj.ColorDictionary("green") = "#96C37D";
            obj.ColorDictionary("yellow") = "#F3D266";
            obj.ColorDictionary("purple") = "#C497B2";
            obj.ColorDictionary("white") = "#F8F3F9";
            
            
            obj.ColorList = [
                obj.ColorDictionary("red");
                obj.ColorDictionary("blue");
                obj.ColorDictionary("green");
                obj.ColorDictionary("yellow");
                obj.ColorDictionary("purple");
                ];
            
            obj.ColorMapOrder = PlotColorManager.Hex2ColorMap(obj.ColorList);
        end
        
    end
    
    methods(Static)
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