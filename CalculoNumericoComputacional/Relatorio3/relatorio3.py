import numpy as np
import matplotlib.pyplot as plt

def Lagrng(x,y,z):
  n = len(x)
  sum = 0
  for i in range(n):
    product = y[i]
    for j in range(n):
      if i!=j:
        product = product *(z-x[j])/(x[i]-x[j])
    sum = sum + product
  return sum

def Newton(x,y,z):
  n = len(x)
  d = np.zeros((n,n))
  for i in range(n):
    d[i][0] = y[i]
  for j in range(1,n):
    for i in range(n-j):
      d[i][j] = (d[i+1][j-1] - d[i][j-1])/(x[i+j]-x[i])

  yint = d[0][0]
  xterm = 1
  for order in range(1,n):
    xterm = xterm * (z-x[order-1])
    yint = yint + d[0][order] * xterm
  return yint

def Spline(x,y,z,t):
  n = len(x)
  h = np.diff(x)
  A = np.zeros((n,n))
  B = np.zeros(n)

  A[0,0] = 1
  A[-1,-1] = 1

  for i in range(1,n-1):
    A[i,i-1] = h[i-1]
    A[i,i] = 2 * (h[i-1] + h[i])
    A[i,i+1] = h[i]
    B[i] = 3 * ((y[i+1]-y[i])/h[i]-(y[i]-y[i-1])/h[i-1])

  yint = np.linalg.solve(A,B)

  i = np.searchsorted(x,z)
  if i == 0:
    i = 1
  elif i == n:
    i = n - 1

  hi = x[i]-x[i-1]
  if t == 0:
    yint = yint[i-1] * (x[i]-z) ** 3/(6*hi) + yint[i] * (z-x[i-1]) ** 3 / (6 * hi) + (y[i-1] -yint[i-1] * hi ** 2 / 6)* (x[i] - z) / hi + (y[i] - yint[i] * hi ** 2 / 6) * (z - x[i - 1]) / hi
    return yint
  else:
    yint = -yint[i-1]*(x[i]-z) ** 2/(2*hi) + yint[i] * (z-x[i-1]) ** 2 / (2 * hi) + (y[i] -y[i-1]) / hi - (yint[i] - yint[i-1]) * hi / 6
    return yint

def AproxLinear(x,y):
  n = len(x)
  sumx = 0
  sumy = 0
  sumxy = 0
  sumx2 = 0
  st = 0
  sr = 0
  for i in range(n):
    sumx = sumx + x[i]
    sumy = sumy + y[i]
    sumxy = sumxy + x[i]*y[i]
    sumx2 = sumx2 + x[i]*x[i]
  xm = sumx/n
  ym = sumy/n
  a1 = (n*sumxy - sumx*sumy)/(n*sumx2 - sumx*sumx)
  a0 = ym - a1*xm
  return a0, a1

def grafico(temperatura,volume):
  plt.scatter(temperatura, volume)
  plt.xlabel("Temperatura")
  plt.ylabel("Volume")
  plt.grid(True)
  plt.show()
