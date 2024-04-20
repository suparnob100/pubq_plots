function adjustAxisProperties2(fig, a, b, bg)
    % Adjust axis properties based on the type of plot in the figure
    % fig: Handle to the figure
    % a, b: Dimensions for box position

    % Set figure and axis units and background color
    set(fig, 'Units', 'inches', 'Color', 'w');
    ax = gca(fig); % Get current axes
    set(ax, 'Units', 'inches', 'Color', bg);
    
    % Adjust the position and size of the axes
    if ~isempty(a) && ~isempty(b)
        BoxPos = [1, 1, a, b];
    else
        BoxPos = [1, 1, 5, 4]; % Default size
    end
    
    adjustAnnotation(ax,a,b)
    set(ax, 'Position', BoxPos);
    
    % Check the type of the primary plot in the figure
    primaryPlot = get(ax, 'Children');
    
    if ~isempty(primaryPlot)
        plotType = class(primaryPlot(end));

        if strcmp(plotType, 'matlab.graphics.chart.primitive.Histogram')
            % Adjust properties specific to histograms
            adjustHistogramProperties(ax, bg, fig);
        elseif strcmp(plotType, 'matlab.graphics.chart.primitive.Bar')
            adjustBarChartProperties(ax, bg, fig)
        else
            % Adjust properties for other plot types
            adjustGeneralPlotProperties(ax, bg, fig);
        end
    else
        warning('No plot found in the figure.');
    end

    adjustFigurePosition(fig, BoxPos);

end

function adjustHistogramProperties(ax, bg, fig)
    % Adjust properties for a histogram
    hHist = findobj(fig, 'Type', 'histogram');
    h = hHist(1);
%     h.BinWidth = 2;
%     h.Normalization = 'probability';
    h.FaceColor = magma(1);
    h.EdgeColor = h.FaceColor;
    h.FaceAlpha = 1.0;
    set(ax, 'XGrid', 'on', 'YGrid', 'on', 'GridColor', 'w', 'GridLineStyle', '-', 'LineWidth', 1);
    set(ax, 'Box', 'off', 'XColor', 'k', 'YColor', 'k');
    set(ax, 'LineWidth', 1.5, 'TickDir', 'out', 'TickLength', [0.02, 0.02]);
    
    % Additional histogram-specific adjustments can be added here
end

function adjustBarChartProperties(ax, bg, fig)
    % Adjust properties for a bar chart
    hBar = findobj(fig, 'Type', 'Bar');
    if isempty(hBar)
        disp('No bar chart found in the figure.');
        return;
    end

    % Determine if it's a single bar chart or grouped bar chart
    if size(hBar(1).YData, 1) == 1
        % Single bar chart
        numBars = numel(hBar.YData); % Number of bars
        cmap = jet(numBars); % Replace 'jet' with your desired colormap
        hBar.CData = cmap;
    else
        % Grouped bar chart
        numGroups = size(hBar(1).YData, 2); % Number of groups
        numBars = numel(hBar); % Number of bars in each group

        for i = 1:numBars
            cmap = jet(numGroups); % Replace 'jet' with your desired colormap
            hBar(i).CData = cmap;
        end
    end

    % Set axes properties
    set(ax, 'XGrid', 'on', 'YGrid', 'on', 'GridColor', 'w', 'GridLineStyle', '-', 'LineWidth', 1);
    set(ax, 'Box', 'off', 'XColor', 'k', 'YColor', 'k');
    set(ax, 'LineWidth', 1.5, 'TickDir', 'out', 'TickLength', [0.02, 0.02]);
    
    % Additional bar chart-specific adjustments can be added here
end

function adjustGeneralPlotProperties(ax, bg, fig)
 
    % Enabling minor ticks
    set(ax, 'XMinorTick', 'off', 'YMinorTick', 'off');

    % Customizing axis properties
    set(ax, 'LineWidth', 1.5, 'TickDir', 'out', 'TickLength', [0.02, 0.02]);

    % Customizing grid lines
    set(ax, 'XGrid', 'on', 'YGrid', 'on', 'GridColor', 'w', 'GridLineStyle', '-','LineWidth',1);

    % Customizing axis colors
    set(ax, 'Box', 'off', 'XColor', 'k', 'YColor', 'k');

end

function adjustFigurePosition(fig, BoxPos)
    % Adjust the position of the figure on the screen
    set(0, 'Units', 'inch');
    monitorPos = get(0, 'MonitorPositions');
    pos = [monitorPos(1, 3)/2 - BoxPos(3)/2, monitorPos(1, 4)/2 - BoxPos(4)/2];
    outerpos = get(gca, 'OuterPosition');
    
    if ~isempty(outerpos)
        set(gca(fig), 'OuterPosition',[0, 0, outerpos(3), outerpos(4)]);
        set(fig, 'Position', [pos(1), pos(2), outerpos(3), outerpos(4)]);
    end

    set(fig,'PaperPositionMode', 'auto');
end

function adjustAnnotation(ax,a,b)
    
    set(0,'defaulttextinterpreter','latex')
    set(0,'DefaultTextFontname', 'CMU Serif')
    set(0,'DefaultAxesFontName', 'CMU Serif')
   
    % Get current axes size
    currentAxesSize = get(ax, 'Position');
    currentWidth = currentAxesSize(3);
    currentHeight = currentAxesSize(4);

    allTextObjects = findall(ax, 'Type', 'text'); % Find all text objects

    % Get handles for xlabel, ylabel, and title
    xlabelHandle = get(ax, 'XLabel');
    ylabelHandle = get(ax, 'YLabel');
    titleHandle = get(ax, 'Title');

    % Exclude axis labels and title from the list
    textAnnotations = allTextObjects(~ismember(allTextObjects, [xlabelHandle, ylabelHandle, titleHandle]));

    for i = 1:length(textAnnotations)
        set(textAnnotations(i), 'FontSize', 15); % Set font size
    end

    for i = 1:length(textAnnotations)
        pos = get(textAnnotations(i), 'Position');
        
        % Calculate relative position
        relativeX = pos(1) / currentWidth;
        relativeY = pos(2) / currentHeight;
    
        % Scale position according to new dimensions a and b
        newPos = [relativeX * a, 0.85*relativeY * b, pos(3:end)]; % Keep the Z position and other dimensions (if any) unchanged
        set(textAnnotations(i), 'Position', newPos);
        
    end

    for i = 1:length(textAnnotations)
        pos = get(textAnnotations(i), 'Position');

        % Check if near the boundary and adjust font size
        if pos(1) > a * 0.8 || pos(2) > b * 0.8 % Example condition
            currentSize = get(textAnnotations(i), 'FontSize');
            newSize = max(currentSize * 0.95, 8); % Reduce font size but not below 8
            set(textAnnotations(i), 'FontSize', newSize);
        end
    end


end

