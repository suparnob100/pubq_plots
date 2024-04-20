function N = determineNumberOfFiles(FileName)
    % Function to determine the number of files based on the FileName input

    % Check if FileName is a cell array
    if iscell(FileName)
        % FileName is a cell array, so N is the number of elements in the cell array
        N = size(FileName, 2);
    else
        % FileName is not a cell array, implying only one file
        N = 1;
    end
end
