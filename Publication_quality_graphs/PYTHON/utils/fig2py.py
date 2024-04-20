import numpy as np
from scipy.io import loadmat

def extract_plot_data(ax_children):
    structured_data = []

    for child in np.atleast_1d(ax_children):
        if 'properties' in child.dtype.names:
            properties = child['properties'][0]

            x_data = properties['XData'][0, 0] if 'XData' in properties.dtype.names else None
            y_data = properties['YData'][0, 0] if 'YData' in properties.dtype.names else None
            z_data = properties['ZData'][0, 0] if 'ZData' in properties.dtype.names else None
            hist_data = properties['Data'][0, 0] if 'Data' in properties.dtype.names else None

            data_item = {}
            if x_data is not None and y_data is not None:
                data_item['XData'] = x_data
                data_item['YData'] = y_data
            if z_data is not None:
                data_item['ZData'] = z_data
            if hist_data is not None:
                data_item['Data'] = hist_data

            if data_item:
                structured_data.append(data_item)

    return structured_data

def fig2py(filename):
    
    filename = filename+'.fig'
    d_contents = loadmat(filename)
    ax_children = d_contents['hgS_070000']['children'][0,0]
    
    if len(ax_children)>1:
        ax_children=ax_children['children'][1,0]
    else:
        ax_children=ax_children['children'][0,0]

    plot_data = extract_plot_data(ax_children)
    
    return plot_data

# data = fig2py('hist')