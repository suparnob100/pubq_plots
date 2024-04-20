function [formatExt, formatSpecifier] = getFormatInfo(formatNumber)
    % Helper function to get format extension and specifier from format number
    % This function assumes a mapping exists between format numbers and file formats

    % Define a map of format numbers to extensions and specifiers

    formatMap = {
        1, '.jpg', '-djpeg';         % JPEG format
        2, '.png', '-dpng';          % PNG format
        3, '.tif', '-dtiff';         % TIFF format (uncompressed)
        4, '.tif', '-dtiffn';        % TIFF format (compressed)
        5, '.emf', '-dmeta';         % EMF format
        6, '.bmp', '-dbmpmono';      % BMP monochrome format
        7, '.bmp', '-dbmp';          % BMP format
        8, '.bmp', '-dbmp16m';       % BMP 16 million colors format
        9, '.bmp', '-dbmp256';       % BMP 256 colors format
        10, '.hdf', '-dhdf';         % HDF format
        11, '.pbm', '-dpbm';         % PBM format
        12, '.pbm', '-dpbmraw';      % PBM raw format
        13, '.pcx', '-dpcxmono';     % PCX monochrome format
        14, '.pcx', '-dpcx24b';      % PCX 24-bit color format
        15, '.pcx', '-dpcx256';      % PCX 256 colors format
        16, '.pcx', '-dpcx16';       % PCX 16 colors format
        17, '.pgm', '-dpgm';         % PGM format
        18, '.pgm', '-dpgmraw';      % PGM raw format
        19, '.ppm', '-dppm';         % PPM format
        20, '.ppm', '-dppmraw';      % PPM raw format
        21, '.pdf', '-dpdf';         % PDF format
        22, '.eps', '-deps';         % EPS format
%         23, '.eps', '-depsc';        % EPS color format
%         24, '.eps', '-deps2';        % EPS Level 2 format
%         25, '.eps', '-depsc2';       % EPS Level 2 color format
        23, '.emf', '-dmeta';        % EMF format again
        24, '.svg', '-dsvg';         % SVG format
%         25, '.ps', '-dps';           % PostScript format
%         29, '.ps', '-dpsc';          % PostScript color format
%         30, '.ps', '-dps2';          % PostScript Level 2 format
%         31, '.ps', '-dpsc2';         % PostScript Level 2 color format
        25, '.fig', 'fig';           % MATLAB figure format
    };

    if(nargin<1)
        % Display format map and choose format number
        disp(formatMap);
        formatExt = input('Enter format Number:');
    else
        % Find the format info in the map
        [formatInfo, formatExt, formatSpecifier]  = formatMap{formatNumber, :};
    end
end
