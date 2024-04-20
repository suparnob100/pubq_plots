function rgb = my_map(N)
    % Ensure the input is a character array
    hex = ['#5e3c99';'#e66101'; '#fdb863'];
    
    % Preallocate the RGB matrix
    rgb = zeros(size(hex, 1), 3);
    
    % Convert each hex color to RGB
    for i = 1:size(hex, 1)
        % Extract the current hex color
        currentHex = hex(i, :);
        
        % Remove the hash symbol if present
        if currentHex(1) == '#'
            currentHex = currentHex(2:end);
        end
        
        % Convert hex to decimal values
        r = hex2dec(currentHex(1:2));
        g = hex2dec(currentHex(3:4));
        b = hex2dec(currentHex(5:6));
        
        % Normalize the RGB values to the range 0-1
        rgb(i, :) = [r, g, b] / 255;
    end
    rgb=rgb(1:N,:);
end
