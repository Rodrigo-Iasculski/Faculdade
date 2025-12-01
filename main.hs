data E = Num Int
      |Var String
      |Soma E E
      |Sub E E
      |Mult E E
      |Div E E
   deriving(Eq,Show)

data B = TRUE
      | FALSE
      | Not B
      | And B B
      | Or  B B
      | Leq E E
      | Igual E E
   deriving(Eq,Show)

data C = While B C
    | If B C C
    | Seq C C
    | Atrib E E
    | Skip
    | TenTimes C
    | Repeat C B
    | Loop E E C
    | DuplaATrib E E E E
    | AtribCond B E E E
    | Swap E E
   deriving(Eq,Show)                
--- A próxima linha de código diz que o tipo memória é equivalente a uma lista de tuplas, onde o
--- primeiro elemento da tupla é uma String (nome da variável) e o segundo um Inteiro (conteúdo da variável):
type Memoria = [(String,Int)]

exSigma :: Memoria
exSigma = [ ("x", 10), ("temp",0), ("y",0)]

--- A função procuraVar recebe uma memória, o nome de uma variável e retorna o conteúdo dessa variável na memória. Exemplo:
procuraVar :: Memoria -> String -> Int
procuraVar [] s = error ("Variavel " ++ s ++ " nao definida no estado")
procuraVar ((s,i):xs) v
  | s == v     = i
  | otherwise  = procuraVar xs v

--- A função mudaVar, recebe uma memória, o nome de uma variável e um novo conteúdo para essa
--- variável e devolve uma nova memória modificada com a varíável contendo o novo conteúdo. Exemplo:
--- *Main> mudaVar exSigma "temp" 20
--- [("x",10),("temp",20),("y",0)]

mudaVar :: Memoria -> String -> Int -> Memoria
mudaVar [] v n = error ("Variavel " ++ v ++ " nao definida no estado")
mudaVar ((s,i):xs) v n
  | s == v     = ((s,n):xs)
  | otherwise  = (s,i): mudaVar xs v n

-----------------------------------------------------------------------------------------------------
---Expressões Aritméticas
-----------------------------------------------------------------------------------------------------
ebigStep :: (E,Memoria) -> Int
ebigStep (Var x,s) = procuraVar s x
ebigStep (Num n,s) = n
ebigStep (Soma e1 e2,s)  = ebigStep (e1,s) + ebigStep (e2,s)
ebigStep (Sub e1 e2,s)   = ebigStep (e1,s) - ebigStep(e2,s)
ebigStep (Mult e1 e2,s)  = ebigStep (e1,s) * ebigStep(e2,s)
ebigStep (Div e1 e2,s)   = div(ebigStep(e1,s)) (ebigStep(e2,s))
-----------------------------------------------------------------------------------------------------
---Expressões Booleanas
-----------------------------------------------------------------------------------------------------
bbigStep :: (B,Memoria) -> Bool
bbigStep (TRUE,s)  = True
bbigStep (FALSE,s) = False

bbigStep (Not b,s) 
   | bbigStep (b,s) == True     = False
   | otherwise                  = True

bbigStep (And b1 b2,s)   = bbigStep(b1,s) && bbigStep(b2,s)
bbigStep (Or b1 b2,s)    = bbigStep(b1,s) || bbigStep(b2,s)
bbigStep (Leq e1 e2,s)   = ebigStep(e1,s) <= ebigStep(e2,s)
bbigStep (Igual e1 e2,s) = ebigStep(e1,s) == ebigStep(e2,s)
-----------------------------------------------------------------------------------------------------
---Expressões de Comando
-----------------------------------------------------------------------------------------------------
cbigStep :: (C,Memoria) -> (C,Memoria)

cbigStep (Skip,s) = (Skip,s)

cbigStep (If b c1 c2,s)
 | bbigStep(b,s) = cbigStep(c1,s)
 | otherwise = cbigStep(c2,s)

cbigStep (Seq c1 c2,s)
 | c0 /= Skip = cbigStep(Seq c0 c2,s1)
 | otherwise = cbigStep(c2,s1)
 where
   (c0,s1) = cbigStep(c1,s)

cbigStep (Atrib (Var x) e,s) = (Skip,mudaVar s x (ebigStep(e,s)))

cbigStep (While b c,s)
 | bbigStep(b,s) = cbigStep(While b c,s0)
 | otherwise = (Skip,s)
 where 
   (_,s0) = cbigStep(c,s)

cbigStep (TenTimes c,s) = cbigStep(Loop (Num 0) (Num 10) c,s)

cbigStep (Repeat c b,s)
 | bbigStep(b,s0) = (Skip,s0)
 | otherwise = cbigStep(Repeat c b,s0) 
 where
   (_,s0) = cbigStep(c,s)

cbigStep(Loop e1 e2 c,s)
 | ebigStep(e2,s) - ebigStep(e1,s) > 0 = cbigStep(Seq c (Loop e1 (Sub e2 (Num 1)) c),s)
 | otherwise = (Skip,s)

cbigStep(DuplaATrib x y e1 e2,s) = cbigStep(Seq (Atrib x e1) (Atrib y e2),s)

cbigStep (AtribCond b x e1 e2,s) 
 | bbigStep(b,s) = cbigStep((Atrib x e1,s))
 | otherwise = cbigStep((Atrib x e2,s))
   
cbigStep(Swap x y,s) = cbigStep(DuplaATrib x y (Num s1) (Num c1),s)
 where (c1,s1) = ((ebigStep(Var "x",s)),(ebigStep(Var "y",s)))
----------------------------------------------------------------------------------------------------  
---Testes
---------------------------------------------------------------------------------------------------- 

-- Loop
sigmaQuadrado :: Memoria
sigmaQuadrado = [("x",1)]

exp10 :: C
exp10 = (Loop (Num 0)(Num 10) (Atrib (Var "x") (Mult (Var "x")(Num 2))))

-- Repeat
sigmaRepeat :: Memoria
sigmaRepeat = [("x",1),("y",2)]

repeatUntil :: C
repeatUntil = (Repeat (Seq (Atrib (Var "x") (Soma (Var "x") (Var "y")))
                           (Atrib (Var "y") (Soma (Var "y") (Num 1))))
                       (Igual (Var "y") (Num 101)))

-- Dupla Atrib, Swap e AtribCond

sigmaAtrib :: Memoria
sigmaAtrib = [("x",0)]

atrib2 :: C
atrib2 = (DuplaATrib (Var "x") (Var "y") (Num 5) (Num 3))

sw :: C
sw = (Swap (Var "x") (Var "y")) 

atribCond :: C
atribCond = (AtribCond FALSE (Var "x") (Num 10) (Num 20))
---------------------Outros testes-------------------

exSigma2 :: Memoria
exSigma2 = [("x",3), ("y",0), ("z",0)]


---
--- O progExp1 é um programa que usa apenas a semântica das expressões aritméticas. Esse
--- programa já é possível rodar com a implementação inicial  fornecida:

progExp1 :: E
progExp1 = Soma (Num 3) (Soma (Var "x") (Var "y"))

---
--- para rodar:
-- *Main> ebigStep (progExp1, exSigma)
-- 13
-- *Main> ebigStep (progExp1, exSigma2)
-- 6

--- Para rodar os próximos programas é necessário primeiro implementar as regras da semântica
---


---
--- Exemplos de expressões booleanas:


teste1 :: B
teste1 = (Leq (Soma (Num 3) (Num 3))  (Mult (Num 2) (Num 3)))

teste2 :: B
teste2 = (Leq (Soma (Var "x") (Num 3))  (Mult (Num 2) (Num 3)))


---
-- Exemplos de Programas Imperativos:

testec1 :: C
testec1 = (Seq (Seq (Atrib (Var "z") (Var "x")) (Atrib (Var "x") (Var "y")))
               (Atrib (Var "y") (Var "z")))

fatorial :: C
fatorial = (Seq (Atrib (Var "y") (Num 1))
                (While (Not (Igual (Var "x") (Num 1)))
                       (Seq (Atrib (Var "y") (Mult (Var "y") (Var "x")))
                            (Atrib (Var "x") (Sub (Var "x") (Num 1))))))
