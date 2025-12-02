import numpy as np
import matplotlib.pyplot as plt
import time

def Bissecao(a, b, p, n, f, i):
    inicio = time.perf_counter()
    x = (a + b)/2
    k = 0
    if f(a) * f(b) > 0:
        print("Nao tem raiz\n")
    else:
        while (i == 0 and n > k) or (i == 1 and abs(f(x)) > p):
            x = (a + b)/2
            k += 1
            if (f(a) < 0 and f(x) > 0) or (f(a) > 0 and f(x) < 0):
                b = x
            else:
                a = x
            if n == k:
                break
    fim = time.perf_counter()
    print(f"Bissecao valor da raiz: {x}, k: {k}, tempo: {fim - inicio:.6f}s\n")

def FalsaPosicao(a,b,p,n,f,i):
    inicio = time.perf_counter()
    x = (a*f(b) - b*f(a))/(f(b) - f(a))
    k = 0
    if(f(a) * f(b) > 0):
        print("Nao tem raiz\n")
    else:
        while((i == 0 and n > k) or (i == 1 and abs(f(x)) > p)):
            x = (a*f(b) - b*f(a))/(f(b) - f(a))
            k += 1
            if((f(a)<0 and f(x)>0) or (f(a)>0 and f(x)<0)):
                b = x
            elif((f(b)<0 and f(x)>0) or (f(b)>0 and f(x)<0)):
                a = x
        fim = time.perf_counter()
        print(f"Falsa posicao valor da raiz: {x}, k: {k}, tempo: {fim - inicio:.6f}s\n")

def NewtonRaphson(x0,p,n,f,i):
    inicio = time.perf_counter()
    h = 1e-5
    k = 0
    while((i == 0 and n > k) or (i == 1 and abs(f(x0)) > p)):
        dr = (f(x0 + h) - f(x0 - h)) / (2*h)
        xk = x0 - f(x0)/dr
        x0 = xk
        k += 1
    fim = time.perf_counter()
    print(f"Newton valor da raiz: {x0}, k: {k}, tempo: {fim - inicio:.6f}s\n")
    return xk

def Secante(x0,x1,p,n,f,i):
    inicio = time.perf_counter()
    k = 0
    while (i == 0 and k < n) or (i == 1 and abs(f(x1)) > p):
        x_Linha = x1 - f(x1)*(x1 - x0)/(f(x1) - f(x0))
        x0, x1 = x1, x_Linha
        k += 1
    fim = time.perf_counter()
    print(f"Secante valor da raiz: {x1}, k: {k}, tempo: {fim - inicio:.6f}s\n")
    return x1

def grafico(f):
    x = np.linspace(-2, 2, 200)
    sig = f(x)
    fig, ax = plt.subplots(figsize=(8,6))
    ax.set_ylim(-4, 4)

    ax.spines["left"].set_position("zero")
    ax.spines["right"].set_color("none")
    ax.spines["bottom"].set_position("zero")
    ax.spines["top"].set_color("none")

    ax.yaxis.tick_left()
    ax.xaxis.tick_bottom()

    plt.plot(x, sig, color="blue")
    plt.show()
