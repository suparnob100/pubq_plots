function showfig()
    % Retrieve handles of all open figures
    figures = findobj('Type', 'figure');

    % Check if there are any open figures
    if isempty(figures)
        disp('No open figures to display.');
    else
        % Bring the most recently used figure to the front
        figure(figures(1));
    end
end
