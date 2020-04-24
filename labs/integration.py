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
