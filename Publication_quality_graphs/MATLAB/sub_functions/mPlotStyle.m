function styleStruct = mPlotStyle()
    % Define a structure for plot style settings

    % Initialize structure
    styleStruct = struct;
    
    % Figure and Axes Background Settings
    styleStruct.FigBackgroundColor = 'w';
    styleStruct.AxesBackgroundColor = [0.95, 0.95, 0.95];

    % Axis Basic Properties
    styleStruct.Axis.LineWidth = 0.75;
    styleStruct.Axis.TickDir = 'out';
    styleStruct.Axis.TickLength = [0.02, 0.02];
    styleStruct.Axis.Box = 'off';
    styleStruct.Axis.XColor = 'k';
    styleStruct.Axis.YColor = 'k';
    styleStruct.Axis.XMinorTick = 'off';
    styleStruct.Axis.YMinorTick = 'off';

    % Axis Grid Properties
    styleStruct.Axis.XGrid = 'on';
    styleStruct.Axis.YGrid = 'on';
    styleStruct.Axis.GridColor = 'w';
    styleStruct.Axis.GridLineStyle = '-';
    styleStruct.Axis.GridLineWidth = 5;

    % Axis Limit and Padding Settings
    styleStruct.Axis.CustomXLim = []; 
    styleStruct.Axis.CustomYLim = [];
    styleStruct.Axis.UseCustomLimits = 0;
    styleStruct.Axis.xPad = 0.01;
    styleStruct.Axis.yPad = 0.00;

    % Line and Scatter Plot Properties
    styleStruct.LineProperties.LineWidth = 2.0;
    styleStruct.LineProperties.MarkerSize = 10;
    styleStruct.ScatterProperties.SizeData = 52;
    styleStruct.ScatterProperties.LineWidth = 1;

    % Histogram Properties
    styleStruct.Histogram.BinWidth = 2;
    styleStruct.Histogram.Normalization = 'probability';
    styleStruct.Histogram.FaceColor = @magma;
    styleStruct.Histogram.EdgeColor = 'none';
    styleStruct.Histogram.FaceAlpha = 0.75;

    % Bar Chart Properties
    styleStruct.BarChart.Colormap = @magma;

    % General Style Properties
    styleStruct.General.FontSize = 15;
    styleStruct.General.FontName = 'CMU Serif';
    styleStruct.General.TextInterpreter = 'tex';

    % Figure Properties Customization
    styleStruct.FigureProperties.ChangeColor = 0;
    styleStruct.FigureProperties.ColorMap = @magma;

    % Legend and Tick Customization
    styleStruct.LegendTick.LegendOrientation = 'horizontal';%'vertical';
    styleStruct.LegendTick.LegendPosition = 1;
    styleStruct.LegendTick.AxisPadding = 0.1;
    styleStruct.Ticks.NumXTicks = 5;
    styleStruct.Ticks.XIntTicks = 0; 
    styleStruct.Ticks.NumYTicks = 5;
    styleStruct.Ticks.YIntTicks = 0;

end
