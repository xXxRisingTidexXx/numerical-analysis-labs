% <pz> ПЗ-12 ЗДУ (Звичайні диференційні рівняння)
% </pz>

% <name> ІПЗ-22 Петраківський Данило
% </name>

% <inputdata>
% ---------------------------------- Nvar= ( 58)
% d a Tau y0 =  -20  32  33 -18
% </inputdata>

% <answer>
% Y(end) = 40.81667662746086
% min(Y) = -18.0
% max(Y) = 43.96680398108463
% </answer>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   22_Petrakivskyi_Danylo_pz012.m

from numpy import linspace, full, min, max
from math import sin, pi
from plotly.graph_objects import Figure, Scatter


def f(xi, yi):
    return (
        0.02 * (32.0 - yi) * (yi + 20.0) +
        20.0 * sin(xi + (pi * 33.0) / 180.0)
    )


x = linspace(0.0, 15.0, 1500)
y = full(1500, -18.0)
for i in range(1, 1500):
    y[i] = y[i - 1] + 0.01 * f(x[i - 1], y[i - 1])

print('Y(end) =', y[-1])
print('min(Y) =', min(y))
print('max(Y) =', max(y))

figure = Figure()
figure.add_trace(Scatter(x=x, y=y, name='y(x)'))
figure.update_layout(xaxis_title='X', yaxis_title='Y')
figure.show()
