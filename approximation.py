from numpy import array, sort, poly1d, polyfit, linspace
from plotly.graph_objects import Scatter, Figure

# Nvar = 58
x = array([0.3495, 0.52017, 1.0481, 1.1996, 1.3005, 1.8142, 1.9631, 2.2837])
y = array([19, 15, 6, 15, 21, 15, 16, 15])
polynomial = poly1d(polyfit(x, y, 5))
xw = sort([1.7297, 0.57076, 1.01, 1.5083, 1.386, 1.6269, 0.37281, 1.3781, 1.2089, 1.1239])
yw = polynomial(xw)
xv = linspace(0.35, 1.7, num=150)
yv = polynomial(xv)

figure = Figure()
figure.add_trace(Scatter(x=x, y=y, mode='lines+markers', name='original'))
figure.add_trace(Scatter(x=xw, y=yw, mode='lines', name='approximated straight'))
figure.add_trace(Scatter(x=xv, y=yv, mode='lines', name='approximated smooth'))
figure.show()
