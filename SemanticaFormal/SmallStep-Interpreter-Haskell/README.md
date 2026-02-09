# SmallStep-Interpreter-Haskell
Projeto feito no 6º semestre de ciência da computação na disciplina de Semântica FOrmal na UFPEl. O projeto mostra a criação da semantica small-step para os seguintes comandos:

- esmallStep (Sub  e1 e2,σ) - Subtração
- esmallStep (Mult e1 e2,σ) - Multiplicação
- esmallStep (Div  e1 e2,σ) - Divisão
- bsmallStep (And  b1 b2,σ) - And booleano
- bsmallStep (Or   b1 b2,σ) - Or booleano
- bsmallStep (Leq  e1 e2,σ) - Menor ou igual
- bsmallStep (Igual e1 e2,σ) - Igualdade
- bsmallStep (if b c1 c2,σ) - If else
- csmallStep (Seq c1 c2,σ) - Sequência de 2 comandos
- csmallStep (Atrib (Var x) e,σ) - Atribuir à "x" o valor da expressão "e"
- While B C - While
- TenTimes C - Executa o comando C 10 vezes
- Repeat C B - Executa C enquanto B é falso
- Loop E E C - Executa(e2 - e1) vezes o comando C
- DuplaAtrib E E E E - Faz e1 := e3 | e2 := e4
- AtribCond B E E E - Se b for verdadeiro, então faz e1 := e2, se for falso, e1 := e3
- Swao E E - Troca o valor das variáveis e1 com e2
 
