# Implementação semântica Big-Step em Haskell

Projeto feito no 6º semestre de ciência da computação na disciplina de Semântica Formal na UFPEl. O projeto mostra a criação da semântica big-step para os seguintes
comandos:
- ebigStep (Sub e1 e2,s)       - Subtração
- ebigStep (Mult e1 e2,s)      - Multiplicação
- ebigStep (Div e1 e2,s)       - Divisão
- bbigStep (And b1 b2,s)       - And booleano
- bbigStep (Or b1 b2,s)        - Or booleano
- bbigStep (Leq e1 e2,s)       - Menor ou igual
- bbigStep (Igual e1 e2,s)     - Igual
- cbigStep (If b c1 c2,s)      - If else
- cbigStep (Seq c1 c2,s)       - Sequência de 2 comandos
- cbigStep (Atrib (Var x) e,s) - Atribuir à "x" o valor da expressão "e" 
- While B C                    - While 
- TenTimes C                   - Executa o comando C 10 vezes
- Repeat C B                   - Executa C enquanto B é falso
- Loop E E C                   - Executa (e2 - e1) vezes o comando C
- DuplaATrib E E E E           - Faz v1:=e1 e v2:=e2
- AtribCond B E E E            - Se b for verdade, então faz v1:e1, se B for falso faz v1:=e2
- Swap E E                     - Troca o conteúdo das variáveis x e y 
