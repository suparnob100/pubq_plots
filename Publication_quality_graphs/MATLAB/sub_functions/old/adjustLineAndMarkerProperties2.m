function adjustLineAndMarkerProperties2(fig,styleSettings)
    % Adjust line and marker properties in a figure
    % styleSettings = mPlotStyle();

    % Find all line objects in the figure
%     lines = findall(fig, 'Type', 'line');
    lines = get(gca(fig), 'Children');
    numLines = length(lines);
    clr = styleSettings.FigureProperties.ColorMap(numLines);

    % Loop through each line object
    for i = 1:numLines
        line = lines(i);

        % Check if it's not a text object
        if(~isa(line, 'matlab.graphics.primitive.Text'))
            % Apply adjustments for line or scatter plots
            if (isa(line, 'matlab.graphics.chart.primitive.Line'))
                set(line, 'LineWidth', styleSettings.LineProperties.LineWidth);
                
                if ~strcmp(get(line, 'Marker'), 'none')
                    set(line, 'MarkerSize', styleSettings.LineProperties.MarkerSize);
                    set(line, 'MarkerEdgeColor', clr(i,:));
                    set(line, 'MarkerFaceColor', clr(i,:));
                end
            
            elseif (isa(line, 'matlab.graphics.chart.primitive.Scatter'))
                set(line, 'SizeData', styleSettings.ScatterProperties.SizeData);
                set(line, 'MarkerEdgeColor', clr(i,:));
                set(line, 'MarkerFaceColor', clr(i,:));
                set(line, 'LineWidth', styleSettings.ScatterProperties.LineWidth);
                            
            else
                % Apply general line adjustments
                set(line, 'LineWidth', styleSettings.LineProperties.LineWidth);
%                 set(line, 'FaceColor', clr(i,:));
%                 set(line, 'EdgeColor', clr(i,:)*0.98);
            end
        end
    end
end
