from numpy import array, cumsum, insert
from scipy.integrate import cumtrapz, simps
from plotly.graph_objects import Scatter, Figure

# Nvar = 58
t = array([
    0, 500, 1000, 1500, 2000, 2500, 3000, 3500,
    4000, 4500, 5000, 5500, 6000, 6500, 7000,
    7218.3454, 7500, 8000, 8500, 9000, 9500, 10000
])
p = array([
    0.415, 1.5644, 4.3021, 7.2122, 9.2387, 15.4965, 16.9678,
    13.7068, 7.7743, 8.6327, 7.504, 5.7415, 5.6334, 4.7871,
    1.0557, 0, 1.3618, 1.8989, 1.9845, 1.9976, 1.9996, 1.9999
])

figure1 = Figure()
figure1.add_trace(Scatter(x=t, y=p, mode='lines+markers'))
figure1.update_layout(xaxis_title='t, s', yaxis_title='P, w')
figure1.show()

figure2 = Figure()
figure2.add_trace(
    Scatter(
        x=t,
        y=insert(cumsum((t[1:] - t[:-1]) * p[:-1]), 0, 0),
        name='left rectangle'
    )
)
figure2.add_trace(
    Scatter(
        x=t,
        y=insert(cumsum((t[1:] - t[:-1]) * p[1:]), 0, 0),
        name='right rectangle'
    )
)
figure2.add_trace(
    Scatter(
        x=t,
        y=insert(cumtrapz(p, t), 0, 0),
        name='trapezoid'
    )
)
figure2.add_trace(
    Scatter(
        x=t,
        y=array([simps(p[0:i], t[0:i]) for i in range(1, len(t) + 1)]),
        name='simpson'
    )
)
figure2.update_layout(xaxis_title='t, s', yaxis_title='E, j')
figure2.show()
