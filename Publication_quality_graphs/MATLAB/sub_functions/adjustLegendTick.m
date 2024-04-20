function adjustLegendTick(fig,styleSettings)
    % Function to adjust legend properties in a figure
    % fig: handle to the figure

    % Load the style settings
    % styleSettings = mPlotStyle();

    % Use the style settings for legend and tick adjustments
    oll = styleSettings.LegendTick.LegendPosition;
    ori = strcmp(styleSettings.LegendTick.LegendOrientation, 'horizontal');
    pad = styleSettings.LegendTick.AxisPadding;

    % Access the legend and axes of the figure
    legendHandle = findobj(fig, 'Type', 'Legend');
    axesHandle = gca;
   
    if isempty(legendHandle)*isempty(axesHandle)
        warning('No legend or axes found in the figure.');
        return;
    end
        
    [~,yLimits] = adjustAxisLimits(fig,styleSettings);

    %% Adjust legend orientation
    if ~isempty(legendHandle)
        
        if exist('ori', 'var') && ori == 1
            set(legendHandle, 'Orientation', 'horizontal');
        end

        % Adjust legend position based on oll value
        if ~isempty(oll)
            % Get current legend and axes positions
            legendHandle.Units='inches';
            legendPos = get(legendHandle, 'Position');
            axesPos = get(axesHandle, 'Position');

            legendBoxH = legendPos(4);

            Y = yLimits(2) - yLimits(1);
            H = axesPos(4);

            legendBoxH_yax = Y*legendBoxH/H;

            if oll == 1 % Position legend down
                % Move the legend below the axes
    %             set(legendHandle, 'Position', [axesPos(1), axesPos(2) - legendPos(4), legendPos(3), legendPos(4)]);
                set(axesHandle, 'YLim', [yLimits(1) - 2*legendBoxH_yax, yLimits(2)]);

            elseif oll == 2 % Position legend up
                % Move the legend above the axes
    %             set(legendHandle, 'Position', [axesPos(1)+axesPos(3)-legendPos(3), axesPos(2) + axesPos(4)-legendPos(4), legendPos(3), legendPos(4)]);
                set(axesHandle, 'YLim', [yLimits(1), yLimits(2)+ 2*legendBoxH_yax]);

            end
            
            legendHandle.Units='normalized';

        end
        
        set(legendHandle,'color','none');
        legend boxoff
        
    end

    %% xtick modification
    primaryPlot = get(axesHandle, 'Children');
    plotType = class(primaryPlot(end));

    
    if ~strcmp(plotType, 'matlab.graphics.chart.primitive.Bar')
        
        % X-axis tick modification
        xLimits = get(axesHandle, 'XLim');
        if length(xticks(axesHandle)) > styleSettings.Ticks.NumXTicks
            xticks(axesHandle, linspace(min(xLimits), max(xLimits), styleSettings.Ticks.NumXTicks));
        end
        
        if styleSettings.Ticks.XIntTicks
            setIntegerTicks(axesHandle, 'x'); % Set integer ticks for X-axis
        end
        
        if (~strcmp(axesHandle.XScale, 'log'))*(max(xLimits)<1000)
            set(axesHandle, 'XTickLabel', arrayfun(@(x) sprintf('%.1f', x), get(axesHandle, 'XTick'), 'UniformOutput', false));
        end

    end

    %% ytick modification
    
    % Y-axis tick modification
    yLimits = get(axesHandle, 'YLim');
    
    if length(yticks(axesHandle)) > styleSettings.Ticks.NumYTicks
        yticks(axesHandle, linspace(min(yLimits), max(yLimits), styleSettings.Ticks.NumYTicks));
    end
    
    if styleSettings.Ticks.YIntTicks
        setIntegerTicks(axesHandle, 'y'); % Set integer ticks for Y-axis
    end
    
    if (~strcmp(axesHandle.YScale, 'log'))*(max(yLimits)<1000)
        set(axesHandle, 'YTickLabel', arrayfun(@(x) sprintf('%.1f', x), get(axesHandle, 'YTick'), 'UniformOutput', false));
    end

    
end

function n = O( val, base)

%Order of magnitude of number for specified base. Default base is 10.
%order(0.002) will return -3., order(1.3e6) will return 6.
%Author Ivar Smith

if nargin < 2
    base = 10;
end
n = floor(log(abs(val))./log(base));

end


function [xLimits,yLimits] = adjustAxisLimits(fig,styleSettings)
    % Function to adjust axis limits of a figure
    % fig: handle to the figure

    % Load the style settings
    % styleSettings = mPlotStyle();

    % Get axes handle
    axesHandle = gca(fig);

    % Check if custom limits are to be used
    if styleSettings.Axis.UseCustomLimits
        % Set custom limits if specified
        if ~isempty(styleSettings.Axis.CustomXLim)
            set(axesHandle, 'XLim', styleSettings.Axis.CustomXLim);
        end
        if ~isempty(styleSettings.Axis.CustomYLim)
            set(axesHandle, 'YLim', styleSettings.Axis.CustomYLim);
        end
    else
        % Use padding-based limits
        axis tight
        xLimits = get(axesHandle, 'XLim');
        yLimits = get(axesHandle, 'YLim');
        xPad = styleSettings.Axis.xPad * (xLimits(2) - xLimits(1));
        yPad = styleSettings.Axis.yPad * (yLimits(2) - yLimits(1));
        set(axesHandle, 'XLim', [xLimits(1) - xPad, xLimits(2) + xPad]);
        set(axesHandle, 'YLim', [yLimits(1) - yPad, yLimits(2) + yPad]);
    end

    xLimits = get(axesHandle, 'XLim');
    yLimits = get(axesHandle, 'YLim');
    
end

function setIntegerTicks(axesHandle, axisType)
    % Set integer ticks for the specified axis (X or Y) of the given axes handle
    % axesHandle: Handle to the axes
    % axisType: 'x' for X-axis, 'y' for Y-axis

    if axisType == 'x'
        axisLimits = get(axesHandle, 'XLim');
    else
        axisLimits = get(axesHandle, 'YLim');
    end

    % Calculate the step size to get at most 5 integer ticks
    range = axisLimits(2) - axisLimits(1);
    stepSize = max(ceil(range / 4), 1); % Ensures at least one tick

    % Generate integer ticks with the calculated step size
    intTicks = ceil(axisLimits(1)/stepSize)*stepSize : stepSize : floor(axisLimits(2)/stepSize)*stepSize;

    % Apply the ticks to the specified axis
    if axisType == 'x'
        set(axesHandle, 'XTick', intTicks);
    else
        set(axesHandle, 'YTick', intTicks);
    end
end

