% <pz> ПЗ-10 Похідна
% </pz>

% <name> ІПЗ-22 Петраківський Данило
% </name>

% <inputdata>
% ---------------------------------- Nvar= ( 58)
% T = 0   5  10  15  20  25  30  35  40  45  50
% H = 348.996       208.936       217.135       273.193       310.174       294.612       226.506       139.324           100       208.936           600
% </inputdata>

% <answer>
% V1(T) = [-28.012    1.6398  11.2116   7.3962  -3.1124 -13.6212 -17.4364  -7.8648
%   21.7872  78.2128]
% V2(T) = [-13.1861   6.4257   9.3039   2.1419  -8.3668 -15.5288 -12.6506   6.9612
%   50.    ]
% A2(T) = [ 5.93036  1.91436 -0.76308 -2.10172 -2.10176 -0.76304  1.91432  5.9304
%  11.28512]
% </answer>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   22_Petrakivskyi_Danylo_pz010.m

from numpy import array, arange
from plotly.graph_objects import Figure, Scatter

dt = 5
t = arange(0, 55, dt)
h = array([
    348.996, 208.936, 217.135, 273.193, 310.174,
    294.612, 226.506, 139.324, 100, 208.936, 600
])

figure1 = Figure()
figure1.add_trace(Scatter(x=t, y=h, mode='lines+markers', name='H(T)'))
figure1.update_layout(xaxis_title='T, s', yaxis_title='H, m')
figure1.show()

v1 = (h[1:] - h[:-1]) / dt
v2 = (h[2:] - h[:-2]) / (2 * dt)
a2 = (h[2:] - 2 * h[1:-1] + h[:-2]) / (dt * dt)

print('V1(T) =', v1)
print('V2(T) =', v2)
print('A2(T) =', a2)

figure2 = Figure()
figure2.add_trace(Scatter(x=t[:-1], y=v1, mode='lines+markers', name='V1(T)'))
figure2.add_trace(Scatter(x=t[1:-1], y=v2, mode='lines+markers', name='V2(T)'))
figure2.add_trace(Scatter(x=t[1:-1], y=a2, mode='lines+markers', name='A2(T)'))
figure2.update_layout(xaxis_title='T, s', yaxis_title='V, m/s; A, m/s^2')
figure2.show()
