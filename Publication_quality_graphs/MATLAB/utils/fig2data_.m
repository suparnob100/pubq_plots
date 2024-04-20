function [plotData] = fig2data_(h2)
% Extracts data from all axes in a MATLAB figure.
% h2: Handle to the figure or name of the .fig file.
% If you have a figure open use gca for h2 instead of gcf

% Load the figure if necessary
if nargin < 1 || isempty(h2)
    [fname, ~] = uigetfile('*.fig', 'Select .fig File', 'MultiSelect', 'off');
    if fname == 0  % User cancelled file selection
        error('No file selected.');
    end
    h = openfig(fname, 'invisible');
else
    h = h2;
end

% Get all axes handles
axesHandles = findobj(h, 'type', 'axes');
numAxes = length(axesHandles);

% Check if there are any axes
if numAxes == 0
    error('No axes found in the figure.');
end

% Initialize output structure
plotData = struct('x', {}, 'y', {}, 'lineStyle', {}, 'marker', {}, 'color', {}, 'xLabel', {}, 'yLabel', {}, 'title', {}, 'legends', {});

% Loop through each axes object
for axIdx = 1:numAxes
    ax = axesHandles(axIdx);
    lines = get(ax, 'Children');

    % Check if there are any line objects
    if isempty(lines)
        warning('No line objects found in axes %d.', axIdx);
        continue;
    end

    numLines = length(lines);
    plotData(axIdx).x = cell(numLines, 1);
    plotData(axIdx).y = cell(numLines, 1);
    plotData(axIdx).lineStyle = cell(numLines, 1);
    plotData(axIdx).marker = cell(numLines, 1);
    plotData(axIdx).color = cell(numLines, 1);

    % Extract data from each line object
    for lineIdx = 1:numLines
        line = lines(lineIdx);
        plotData(axIdx).x{lineIdx} = get(line, 'XData');
        plotData(axIdx).y{lineIdx} = get(line, 'YData');
        
        if ~isa(line, 'matlab.graphics.chart.primitive.Scatter')
            plotData(axIdx).lineStyle{lineIdx} = get(line, 'LineStyle');
        end
        
        % Check for marker property
        if (~isa(line, 'matlab.graphics.chart.primitive.Area') * ~isa(line, 'matlab.graphics.chart.primitive.bar'))
            
            marker = get(line, 'Marker');
            if ~isempty(marker) && ~strcmp(marker, 'none')
                plotData(axIdx).marker{lineIdx} = marker;
            else
                plotData(axIdx).marker{lineIdx} = 'None';
            end
        
        end

        % Check if the object is a line or scatter plot and get the color accordingly
        if isa(line, 'matlab.graphics.chart.primitive.Line')
            plotData(axIdx).color{lineIdx} = get(line, 'Color');
        elseif isa(line, 'matlab.graphics.chart.primitive.Scatter')
            plotData(axIdx).color{lineIdx} = get(line, 'MarkerEdgeColor');
        end

    end

    % Extract axes labels and title
    plotData(axIdx).xLabel = get(get(ax, 'XLabel'), 'String');
    plotData(axIdx).yLabel = get(get(ax, 'YLabel'), 'String');
    plotData(axIdx).title = get(get(ax, 'Title'), 'String');

    % Handle legends

    if ~isempty(ax.Legend)
        plotData(axIdx).legends = {ax.Legend.String};
    else
        plotData(axIdx).legends = {};
    end
end

% Close the figure if it was opened in this function
if nargin < 1 || isempty(h2)
    close(h);
end

end
