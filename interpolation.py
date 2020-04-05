from numpy import array, sort
from scipy.interpolate import interp1d
from plotly.graph_objects import Scatter, Figure

# Nvar = 58
x = array([0.3495, 0.52017, 1.0481, 1.1996, 1.3005, 1.8142, 1.9631, 2.2837])
y = array([19, 15, 6, 15, 21, 15, 16, 15])
xw = sort([1.7297, 0.57076, 1.01, 1.5083, 1.386, 1.6269, 0.37281, 1.3781, 1.2089, 1.1239])

ywnn = interp1d(x, y, kind='nearest')(xw)
ywl = interp1d(x, y, kind='linear')(xw)
ywc = interp1d(x, y, kind='cubic')(xw)

figure = Figure()
figure.add_trace(Scatter(x=x, y=y, mode='markers', name='original'))
figure.add_trace(Scatter(x=xw, y=ywnn, mode='lines+markers', name='nearest neighbour'))
figure.add_trace(Scatter(x=xw, y=ywl, mode='lines+markers', name='linear'))
figure.add_trace(Scatter(x=xw, y=ywc, mode='lines+markers', name='cubic'))
figure.show()
