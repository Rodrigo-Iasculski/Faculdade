# SmallStep-Interpreter-Haskellã
Projeto feito no 6º semestre de ciência da computação na disciplina de Semântica Formal na UFPEl. O projeto mostra a criação da semântica small-step para os seguintes comandos:

- esmallStep (Sub e1 e2,σ)   - Subtração
- esmallStep (Mult e1 e2,σ)  - Multiplicação
- esmallStep (Div e1 e2,σ)   - Divisão
- bsmallStep (And b1 b2,σ)   - And booleano
- bsmallStep (Or b1 b2,σ)    - Or booleano
- bsmallStep (Leq e1 e2,σ)   - Menor ou igual
- bsmallStep (Igual e1 e2,σ) - Igualdade
- bsmallStep (If b c1 c2,σ)      - Se B for verdadeiro faz C1, caso contrário faz C2
- csmallStep (Seq c1 c2,σ)       - Realiza C1 depois C2
- csmallStep (Atrib (Var x) e,σ) - Atribuir à X o valor da expressão E
- csmallStep (While b c,σ)       - Enquanto B for verdadeiro faz C
- csmallStep (TenTimes c,σ)      - Executa o comando C 10 vezes
- csmallStep (Repeat c b,σ)      - Executa C enquanto B é falso
- csmallStep (Loop e1 e2 c,σ)    - Executa (e2 - e1) vezes o comando C
- csmallStep (DuplaATrib v1 v2 e1 e2,σ) - Faz v1:=e1 e v2:=e2
- csmallStep (AtribCond b v1 e1 e2,σ)   - Se b for verdade, então faz v1:e1, se B for falso faz v1:=e2
- csmallStep (Swap v1 v2,σ) - Troca o conteúdo das variáveis v1 com v2
