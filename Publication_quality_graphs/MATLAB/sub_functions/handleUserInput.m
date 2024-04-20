function [FileName, PathName, Filepath, frmt] = handleUserInput(select, figname, formats1)
    % Function to handle user inputs and determine file paths and formats

    if select == 1
        % User chooses to select files through a dialog box
        [FileName, PathName] = uigetfile('*.fig', 'Select Figure Files', 'MultiSelect', 'on');
        if isequal(FileName, 0) || isequal(PathName, 0)
            error('No file selected');
        end
        disp(formats1);
        frmt = formats1;
        Filepath = strcat(PathName, FileName);
    else
        % User provides file names directly
        if iscell(figname)
            % Multiple file names provided
            for ii = 1:size(figname, 2)
                Filepath0{ii} = openfig(figname{ii});
                Filepath{ii} = Filepath0{ii}.FileName;
                [PathName, FileName{ii}] = fileparts(Filepath{ii});
            end
        else
            % Single file name provided
            Filepath0 = openfig(figname);
            Filepath = Filepath0.FileName;
            [PathName, FileName] = fileparts(Filepath);
            PathName = strcat(PathName,'\');
        end
        frmt = formats1;
    end
end
