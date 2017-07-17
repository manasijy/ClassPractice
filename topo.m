classdef topo < handle
% topo is a subclass of handle
    properties
        FigHandle % Store figure handle
        FofXY % function handle
        Lm = [-2*pi 2*pi] % Initial limits
    end % properties
    properties (Dependent, SetAccess = private)
        Data
    end % properties Dependent = true, SetAccess = private
    methods
        function obj = topo(fnc,limits)
        % Constructor assigns property values
            obj.FofXY = fnc;
            obj.Lm = limits;
        end % topo
        function set.Lm(obj,lim)
        % Lm property set function
            if ~(lim(1) < lim(2))
                error('Limits must be monotonically increasing')
            else
                obj.Lm = lim;
            end
        end % set.Lm
        function data = get.Data(obj)
        % get function calculates Data
        % Use class name to call static method
            [x,y] = topo.grid(obj.Lm);
            matrix = obj.FofXY(x,y);
            data.X = x;
            data.Y = y;
            data.Matrix = matrix;% Return value of property
        end % get.Data
        function surflight(obj)
        % Graph function as surface
            obj.FigHandle = figure;
            surfc(obj.Data.X,obj.Data.Y,obj.Data.Matrix,...
            'FaceColor',[.8 .8 0],'EdgeColor',[0 .2 0],...
            'FaceLighting','gouraud');
            camlight left; material shiny; grid off
            colormap copper
        end % surflight method
        function delete(obj)
        % Delete the figure
            h = obj.FigHandle;
                if ishandle(h)
                    delete(h);
                else
                return
                end
        end % delete
    end % methods
    methods (Static = true) % Define static method
        function [x,y] = grid(lim)
            inc = (lim(2)-lim(1))/35;
            [x,y] = meshgrid(lim(1):inc:lim(2));
        end % grid
    end % methods Static = true
end % topo class

% use as : tobj = topo(@(x,y) x.*exp(-x.^2-y.^2),[-2 2]);

%properties (SetAccess = private, GetAccess = public)