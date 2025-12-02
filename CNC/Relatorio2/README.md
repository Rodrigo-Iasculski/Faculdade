# Métodos para encontrar raizes
Projeto feito para solucionar sistemas de equações lineares e não lineares para a matéria de Cálculo Numérico Computacional na UFPEL.
Métodos:
- Eliminacão de Gauss
    - Zera elementos abaixo da diagonal para triangular a matriz e depois resolve por substituição reversa
- Fatoração de LU
    - Decompõe a matriz em 2 -- triangular inferior e superior -- para resolver o sistema
- Fatoração de Cholesky
    - Decompõe a matriz em 2 -- triangular inferior e a transposta -- para resolver o sistema
- Gauss Jacobi
    - Aproxima x iterativamente usando apenas os valores da iteração anterior
- Gauss Seidel
    - Atualiza os valores de x à medida que vão sendo calculados, acelerando a convergência

