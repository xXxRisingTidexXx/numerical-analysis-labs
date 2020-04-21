% <pz> ПЗ-13 Повороти систем координат
% </pz>

% <name> ІПЗ-22 Петраківський Данило
% </name>

% <inputdata>
% Length of RobotArms L1 L2 L3 = 8  4  8
% Alpha1,2,3, Beta = 6  16  22   4 Degree
% </inputdata>

% <answer>
% [[ 0.  7.93679432 11.63649545 17.37719564]
%  [ 0.  0.83622771  2.33465408  7.89192104]
%  [ 0. -0.55499472 -0.81370303 -1.21513189]]
% </answer>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   22_Petrakivskyi_Danylo_pz013.m

from math import pi, sin, cos
from numpy import array, ndarray, zeros
from plotly.graph_objects import Figure, Scatter3d, Scatter


def rad(deg: float) -> float:
    return deg * pi / 180


def rotation2d(a: float) -> ndarray:
    c, s = cos(a), sin(a)
    return array([[c, -s, 0.0], [s, c, 0.0], [0.0, 0.0, 1.0]])


def rotation3d(a: float) -> ndarray:
    c, s = cos(a), sin(a)
    return array([[c, 0.0, s], [0.0, 1.0, 0.0], [-s, 0.0, c]])


a1, a2, a3, b = rad(6), rad(22), rad(44), rad(4)
v = array([[8.0, 4.0, 8.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]])
p0 = zeros((3, 4))
p0[:, 1] = v[:, 0]
p0[:, 2] = p0[:, 1] + v[:, 1]
p0[:, 3] = p0[:, 2] + v[:, 2]
p1 = zeros((3, 4))
p1[:, 1] = rotation2d(a1) @ v[:, 0]
p1[:, 2] = p1[:, 1] + rotation2d(a2) @ v[:, 1]
p1[:, 3] = p1[:, 2] + rotation2d(a3) @ v[:, 2]
rotation = rotation3d(b)
p1[:, 1] = rotation @ p1[:, 1]
p1[:, 2] = rotation @ p1[:, 2]
p1[:, 3] = rotation @ p1[:, 3]

print(p1)

figure1 = Figure()
figure1.add_trace(Scatter(x=p0[0], y=p0[1], name='initial'))
figure1.add_trace(Scatter(x=p1[0], y=p1[1], name='rotation'))
figure1.show()
figure2 = Figure()
figure2.add_trace(Scatter3d(x=p0[0], y=p0[1], z=p0[2], name='initial'))
figure2.add_trace(Scatter3d(x=p1[0], y=p1[1], z=p1[2], name='rotation'))
figure2.show()
