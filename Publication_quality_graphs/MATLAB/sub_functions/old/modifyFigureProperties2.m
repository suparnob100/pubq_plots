function modifyFigureProperties2(fig)
    % Function to modify properties of a figure
    % fig: handle to the figure
    % fnt: font size for axis labels

    % Define a color palette (example colors, can be modified)
    styleSettings = mPlotStyle();
% 
%     cmap = [ 0.90196  0.38039  0.00392;... % RED
%           0.36863  0.23529  0.60000;... % VIOLET
%           0.99216  0.72157  0.38824;... % YELLOW
%         ];
    
    % Set font size of axes
    set(gca(fig), 'FontSize', styleSettings.General.FontSize);%, 'FontWeight', 'bold', 'FontAngle', 'italic');

    % Modify line and histogram colors if the flag is set
    if styleSettings.FigureProperties.ChangeColor
        
        % Modify line colors
        hline = findobj(fig, 'type', 'line');
        if ~isempty(hline)
            nol = length(hline);
            cmap = styleSettings.FigureProperties.ColorMap(nol);
            for clp = 1:nol
                set(hline(clp),'Color',cmap(clp,:));
            end
        end

        % Modify histogram colors
        hHist = findobj(fig, 'Type', 'histogram');
        if ~isempty(hHist)
            cmap = styleSettings.FigureProperties.ColorMap(length(hHist));
            for i = 1:length(hHist)
                hHist(i).FaceColor = cmap(i, :);
            end
        end

        % Modify bar plot colors
        hBar = findobj(fig, 'Type', 'Bar');
        if ~isempty(hBar)
            cmap = styleSettings.FigureProperties.ColorMap(length(hBar));
            for i = 1:length(hBar)
                hBar(i).FaceColor = 'flat';
                hBar(i).CData = cmap(i, :);
            end
        end
    end

end
