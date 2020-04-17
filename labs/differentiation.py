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
