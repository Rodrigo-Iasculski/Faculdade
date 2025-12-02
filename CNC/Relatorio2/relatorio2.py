import numpy as np
import sympy as sp

def eliminacaoGauss(a, b):
  n = len(a)
  for k in range(n-1):
    for i in range(k+1,n):
      m = (a[i][k])/(a[k][k])
      a[i][k] = 0
      for j in range(k+1,n):
        a[i][j] = a[i][j] - m*a[k][j]
      b[i] = b[i] -  m*b[k]
  teste = np.linalg.solve(a,b)
  print(teste)

def lu(A,B):
  n = len(A)
  L = np.eye(n)

  for k in range(n-1):
    for i in range(k+1,n):
      m = -A[i][k]/A[k][k]
      L[i][k] = -m
      for j in range(k+1,n):
        A[i][j] = m * A[k][j] + A[i][j]
      A[i][k] = 0
  LU = np.matmul(L,A)
  x = np.linalg.solve(LU,B)
  #print("U:\n",A)
  #print("L:\n",L)
  return x

def cholesky(A,B):
  n = len(A)
  G = np.zeros((n,n))

  for j in range(n):
    soma = 0
    for k in range(j):
      soma += G[j][k]**2
    t = A[j][j] - soma
    if(t>0):
      G[j][j] = np.sqrt(t)
    for i in range(j+1,n):
      soma = 0
      for k in range(j):
        if(A[i][j] != A[j][i]):
          return "Nao é simetrico"
        soma += G[i][k] * G[j][k]
      G[i][j] = (A[i][j]-soma)/G[j][j]
  y = np.linalg.solve(G,B)
  GT = np.transpose(G)
  x = np.linalg.solve(GT,y)

  return x
def gaussJacobi(A,B,p,max):
  n = len(A)
  x = np.zeros(n)
  v = np.zeros(n)

  for i in range(n):
    for j in range(n):
      if i != j:
        A[i][j] = A[i][j] / A[i][i]
    B[i] = B[i]/A[i][i]
    x[i] = B[i]
  for k in range(1,max+1):
    for i in range(n):
      s = 0
      for j in range(n):
        if i != j:
          s = s + A[i][j] * x[j]
      v[i] = B[i] - s
    if np.linalg.norm(x - v, np.inf) <= p:
      return v
    x = v.copy()

def gaussSeidel(A,B,x0,p,max):
  n = len(A)
  x = np.array(x0,float)

  for k in range(max):
    x_Linha = x.copy()
    for i in range(n):
      s = 0
      for j in range(n):
        if i != j:
          s = s + A[i][j] * x[j]
      x[i] = (B[i] - s)/A[i][i]
    if np.linalg.norm(x - x_Linha, np.inf) < p:
      break
  return x

def newton(f, j, x0, p, max):
    x = np.array(x0,float)

    for k in range(max):
        fx = np.array(f(x[0], x[1]),float)
        jx = np.array(j(x[0], x[1]),float)

        s = np.linalg.solve(jx, -fx)
        x_Linha = x + s

        fx_Linha = np.array(f(x_Linha[0], x_Linha[1]), float)

        if np.linalg.norm(fx_Linha) < p and np.linalg.norm(s) < p:
            return x_Linha, k+1

        x = x_Linha

    return x, max

#Funções auxiliares
def linhasColunas(A):
  n = len(A)
  for i in range(n):
    linhas = 0
    colunas = 0
    for j in range(n):
      if j != i:
        linhas += abs(A[i][j])
        colunas += abs(A[j][i])
    if not(A[i][i] > linhas and A[i][i] >colunas):
      return'Critério das linhas e colunas falhou'
  return'Passou nos critérios das linhas e colunas'

def sassenfield(A):
  n = len(A)
  beta = [1,1,1]
  linhas = np.zeros((n,n))
  for i in range(n):
    linhas = 0
    for j in range(n):
      if j != i:
        linhas += abs(A[i][j]) * (beta[j] if j < i else 1)
    beta[i] = linhas / abs(A[i][i])
    if beta[i] >= 1:
      return'Criterio de sassenfield falhou'
  return'Passou no criterio de sassenfield'

def truncar(x):
    num = np.floor(np.log10(abs(x)))
    val = 10 ** (1 - num)
    return np.trunc(x * val) / val

