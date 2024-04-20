function printOutput(fig, FileName, PathName, frmt, i)
    % Function for printing or saving the figure in specified formats
    % fig: Handle to the figure
    % FileName: Name of the file to save
    % frmt: Format(s) in which to save the figure
    % i: Index of the current file being processed

    % Get the filename for the current figure
    if iscell(FileName)
        [~,currentFileName,~] = fileparts(FileName{i});
    else
        [~,currentFileName,~] = fileparts(FileName);
    end

    % Iterate through each specified format
    for j = 1:length(frmt)
        % Determine the format extension and format specifier
        [formatExt, formatSpecifier] = getFormatInfo(frmt(j));
  
        % Save or print the figure based on the format
        switch formatSpecifier
            case 'fig'
                % Save as MATLAB figure
                savefig(fig, strcat(PathName,currentFileName));
                
            case {'-dpdf','-deps','-dsvg','-dpng','-dtiff','-dtiffn','-djpg', '-dbmp', '-dbmp16m', '-dbmp256'}
                export_fig(strcat(PathName,currentFileName,formatExt), '-q101','-transparent','-painters');

            % case {'-dpdf','-deps','-dpng','-dtiff','-dtiffn','-djpg'}
                % exportgraphics(gca(fig),strcat(PathName,currentFileName,formatExt), "Resolution",4800);
                
            otherwise
                % Print using the specified format
                print(fig,  formatSpecifier, strcat(PathName,currentFileName));
        end
    end
end