classdef LineType < matlab.mixin.SetGet
    properties
        Style = '-'
        Marker = 'o'
    end
    properties (SetAccess = protected)
        Units = 'points'
    end
    methods
        function obj = LineType(s,m)
            if nargin > 0
                obj.Style = s;
                obj.Marker = m;
            end
        end
        function obj = set.Style(obj,val)
            if ~(strcmpi(val,'-') ||...
                strcmpi(val,'--') ||...
                strcmpi(val,'..'))
                error('Invalid line style ')
            end
            obj.Style = val;
        end
        function obj = set.Marker(obj,val)
            if ~isstrprop(val,'graphic')
                error('Marker must be a visible character')
            end
            obj.Marker = val;
        end
    end
end