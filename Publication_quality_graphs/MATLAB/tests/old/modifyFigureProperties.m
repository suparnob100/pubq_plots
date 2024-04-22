function modifyFigureProperties(fig, fnt, chngc)
    % Function to modify properties of a figure
    % fig: handle to the figure
    % fnt: font size for axis labels
    % chngc: flag to change color

    % Define a color palette (example colors, can be modified)
    cmap = [ 0.90196  0.38039  0.00392;... % RED
          0.36863  0.23529  0.60000;... % VIOLET
          0.99216  0.72157  0.38824;... % YELLOW
        ];
    
    % Set font size of axes
    if exist('fnt', 'var') && ~isempty(fnt)
        set(gca(fig), 'FontSize', fnt)%, 'FontWeight', 'bold', 'FontAngle', 'italic');
    else
        set(gca(fig),'FontSize',14); % Default font size
    end

    % Modify line colors if chngc flag is set
    if exist('chngc', 'var') && chngc == 1
        hline = findobj(fig, 'type', 'line');
        nol = length(hline);
        cmap = magma(nol);
        for clp = 1:nol
            set(hline(clp),'Color',cmap(clp,:));
        end
    end

    % Modify histogram colors if chngc flag is set
    if exist('chngc', 'var') && chngc == 1
        % Find the histogram object in the figure
        hHist = findobj(fig, 'Type', 'histogram');

        if ~isempty(hHist)
            % Generate a colormap
            cmap = magma(length(hHist)); % Assuming magma() returns a colormap
            for i = 1:length(hHist)
                % Set the color of each histogram
                hHist(i).FaceColor = cmap(i, :);
            end
        end
    end
    
    % Modify bar plot colors if chngc flag is set
    if exist('chngc', 'var') && chngc == 1
        % Find the bar objects in the figure
        hBar = findobj(fig, 'Type', 'Bar');

        if ~isempty(hBar)
            % Generate a colormap
            cmap = magma(length(hBar)); % Replace with your desired colormap

            for i = 1:length(hBar)
                % Set the color of each bar group
                % For grouped bar charts, hBar(i).CData can be a matrix
                hBar(i).FaceColor = 'flat';
                hBar(i).CData = cmap(i, :);
            end
        end
    end


end
