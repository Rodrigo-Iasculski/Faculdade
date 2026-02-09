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
- cbigStep (If b c1 c2,s)      - Se B for verdadeiro faz C1, caso contrário faz C2
- cbigStep (Seq c1 c2,s)       - Sequência de 2 comandos
- cbigStep (Atrib (Var x) e,s) - Atribuir à X o valor da expressão E
- cbigStep (While b c,s)       - Enquanto B for verdadeiro faz C
- cbigStep (TenTimes c,s)      - Executa o comando C 10 vezes
- cbigStep (Repeat c b,s)      - Executa C enquanto B é falso
- cbigStep (Loop e1 e2 c,s)    - Executa (e2 - e1) vezes o comando C
- cbigStep (DuplaATrib v1 v2 e1 e2,s) - Faz v1:=e1 e v2:=e2
- cbigStep (AtribCond b v1 e1 e2,s)   - Se b for verdade, então faz v1:e1, se B for falso faz v1:=e2
- cbigStep (Swap v1 v2,s) - Troca o conteúdo das variáveis v1 com v2
