function fig = openFigure(Filepath, i)
    % Function to open the figure file based on the Filepath and index i

    % Check if Filepath is a cell array, implying multiple file paths
    if iscell(Filepath)
        % Open the figure file at the index i in the cell array
        fig = openfig(Filepath{i}); % 'invisible' prevents the figure from being displayed immediately
    else
        % If Filepath is not a cell array, open the single file
        fig = openfig(Filepath); % Same here for 'invisible'
    end
end

