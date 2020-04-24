% <pz> ПЗ-11 Інтеграл
% </pz>

% <name> ІПЗ-22 Петраківський Данило
% </name>

% <inputdata>
% ---------------------------------- Nvar= ( 58)
% T[sec] = 0    500   1000   1500   2000   2500   3000   3500   4000   4500   5000   5500   6000   6500   7000   7500   8000   8500   9000   9500  10000
% P = 0.415       1.5644       4.3021       7.2122       9.2387      15.4965      16.9678      13.7068       7.7743       8.6327        7.504       5.7415       5.6334       4.7871       1.0557      -1.3618      -1.8989      -1.9845      -1.9976      -1.9996      -1.9999
% </inputdata>

% <answer>
% E1 = [    0.           207.5          989.7         3140.75
%   6746.85       11366.2        19114.45       27598.35
%  34451.75       38338.9        42655.25       46407.25
%  49278.         52094.7        54488.25       54718.75723878
%  54718.75723878 55399.65723878 56349.10723878 57341.35723878
%  58340.15723878 59339.95723878]
% E2 = [    0.           782.2         2933.25        6539.35
%  11158.7        18906.95       27390.85       34244.25
%  38131.4        42447.75       46199.75       49070.5
%  51887.2        54280.75       54808.6        54808.6
%  55192.15723428 56141.60723428 57133.85723428 58132.65723428
%  59132.45723428 60132.40723428]
% E3 = [    0.           494.85        1961.475       4840.05
%   8952.775      15136.575      23252.65       30921.3
%  36291.575      40393.325      44427.5        47738.875
%  50582.6        53187.725      54648.425      54763.67861939
%  54955.45723653 55770.63223653 56741.48223653 57737.00723653
%  58736.30723653 59736.18223653]
% E4 = [    0.           494.85        1829.11666667  4707.69166667
%   8894.05       15077.85       23592.8        31261.45
%  36854.35       40956.1        45155.86666667 48467.24166667
%  51173.1        53778.225      55479.35       55594.60361939
%  55786.38223653 56601.55723653 57610.03223653 58605.55723653
%  59605.78223653 60605.65723653]
% </answer>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   22_Petrakivskyi_Danylo_pz011.m

from numpy import array, cumsum, insert, abs, ndarray, sum, zeros
from plotly.graph_objects import Scatter, Figure


def trapezoid(x: ndarray, y: ndarray) -> ndarray:
    return (x[1:] - x[:-1]) * (y[:-1] + y[1:]) / 2.0


def simpson(y: ndarray, dx: float) -> float:
    if len(y) % 2 == 0:
        return simpson(y[:-1], dx) + (y[-2] + y[-1]) * dx / 2.0
    return sum(y[0:-1:2] + 4.0 * y[1::2] + y[2::2]) * dx / 3.0


t = array([
    0, 500, 1000, 1500, 2000, 2500, 3000, 3500,
    4000, 4500, 5000, 5500, 6000, 6500, 7000,
    7218.3454, 7500, 8000, 8500, 9000, 9500, 10000
])
p = array([
    0.415, 1.5644, 4.3021, 7.2122, 9.2387, 15.4965, 16.9678,
    13.7068, 7.7743, 8.6327, 7.504, 5.7415, 5.6334, 4.7871,
    1.0557, 0, -1.3618, -1.8989, -1.9845, -1.9976, -1.9996, -1.9999
])
pabs = abs(p)

e1 = insert(cumsum((t[1:] - t[:-1]) * pabs[:-1]), 0, 0)
e2 = insert(cumsum((t[1:] - t[:-1]) * pabs[1:]), 0, 0)
e3 = insert(cumsum(trapezoid(t, pabs)), 0, 0)
e4 = zeros(len(e3))
for i in range(1, 15):
    e4[i] = simpson(pabs[:i + 1], 500)
for i in range(15, 17):
    e4[i] = e4[i - 1] + trapezoid(t[i - 1:i + 1], pabs[i - 1:i + 1])
for i in range(17, len(e3)):
    e4[i] = e4[16] + simpson(pabs[16:i + 1], 500)

print('E1 =', e1)
print('E2 =', e2)
print('E3 =', e3)
print('E4 =', e4)

figure1 = Figure()
figure1.add_trace(Scatter(x=t, y=p, mode='lines+markers'))
figure1.update_layout(xaxis_title='t, s', yaxis_title='P, w')
figure1.show()

figure2 = Figure()
figure2.add_trace(Scatter(x=t, y=e1, name='left rectangle'))
figure2.add_trace(Scatter(x=t, y=e2, name='right rectangle'))
figure2.add_trace(Scatter(x=t, y=e3, name='trapezoid'))
figure2.add_trace(Scatter(x=t, y=e4, name='simpson'))
figure2.update_layout(xaxis_title='t, s', yaxis_title='E, j')
figure2.show()
