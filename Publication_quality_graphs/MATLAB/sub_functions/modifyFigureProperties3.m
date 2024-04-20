function modifyFigureProperties3(fig, styleSettings)
    % Function to modify properties of a figure
    % fig: handle to the figure
    % styleSettings: structure with style settings
    
    % styleSettings = mPlotStyle();


    % Set font size for all axes in the figure
    axesInFig = findobj(fig, 'Type', 'axes');
    for ax = axesInFig'
        set(ax, 'FontSize', styleSettings.General.FontSize);
    end

    % Modify line and plot colors if the flag is set
    if styleSettings.FigureProperties.ChangeColor
        modifyLineAndPlotColors(fig, styleSettings);
    end
end

function modifyLineAndPlotColors(fig, styleSettings)
    % Modify colors for lines and apply adjustments for histograms and bar charts
    lines = findobj(fig, 'Type', 'line');
    applyLineAndMarkerColor(lines, styleSettings.FigureProperties.ColorMap);
    ax = findobj(fig, 'Type', 'axes');
    for a = 1:length(ax)
        primaryPlot = get(ax(a), 'Children');
        if ~isempty(primaryPlot)
            plotType = class(primaryPlot(end));
            if strcmp(plotType,'matlab.graphics.primitive.Patch')+strcmp(plotType, 'matlab.graphics.chart.primitive.Histogram')
                adjustHistogramProperties(ax(a), styleSettings);
            elseif strcmp(plotType, 'matlab.graphics.chart.primitive.Bar')
                adjustBarChartProperties(ax(a), styleSettings);
            end
        end
    end
end

function applyLineAndMarkerColor(lines, colormapFunc)
    % Apply color to line objects
    numLines = length(lines);
    cmap = colormapFunc(numLines);
    for i = 1:numLines
        lines(i).Color = cmap(i, :);
        line = lines(i);

        if(~isa(line, 'matlab.graphics.primitive.Text'))
            % Apply adjustments for line or scatter plots
                
            if ~strcmp(get(line, 'Marker'), 'none')
                set(line, 'MarkerEdgeColor', cmap(i,:));
                set(line, 'MarkerFaceColor', cmap(i,:));
            end

            if (isa(line, 'matlab.graphics.chart.primitive.Scatter'))
                set(line, 'MarkerEdgeColor', cmap(i,:));
                set(line, 'MarkerFaceColor', cmap(i,:));
            end

        end

    end
end

function adjustHistogramProperties(ax, styleSettings)
    
    plotChildren = get(ax, 'Children');
    cmap = styleSettings.Histogram.FaceColor(length(plotChildren));

    for h = 1:length(plotChildren)
        hHist = plotChildren(h);
        
        if isprop(hHist, 'FaceColor')
            hHist.FaceColor = cmap(h,:);
        end

        if isprop(hHist, 'EdgeColor')
            hHist.EdgeColor = styleSettings.Histogram.EdgeColor;
        end

        if isprop(hHist, 'FaceAlpha')
            hHist.FaceAlpha = styleSettings.Histogram.FaceAlpha;
        end


    end
end

function adjustBarChartProperties(ax, styleSettings)
    
    hBar = findobj(ax, 'Type', 'bar');
    
    if isempty(hBar)
        warning('No bar chart found.');
        return;
    end
    
    cmap = styleSettings.BarChart.Colormap(length(hBar));

    for h = 1:length(hBar)
%         numGroups = size(hBar(h).YData, 2);
        hBar(h).CData = cmap;
        hBar(h).FaceColor = cmap;
        hBar(h).EdgeColor = cmap(h,:)*0.98;

    end
    
end


