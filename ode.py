from numpy import linspace, full
from math import sin, pi
from plotly.graph_objects import Figure, Scatter


# Nvar = 58
def f(xi, yi):
    return (
        0.02 * (32.0 - yi) * (yi + 20.0) +
        20.0 * sin(xi + (pi * 33.0) / 180.0)
    )


x = linspace(0.0, 15.0, 1500)
y = full(1500, -18.0)
for i in range(1, 1500):
    y[i] = y[i - 1] + 0.01 * f(x[i - 1], y[i - 1])

figure = Figure()
figure.add_trace(Scatter(x=x, y=y, name='y(x)'))
figure.update_layout(xaxis_title='X', yaxis_title='Y')
figure.show()
