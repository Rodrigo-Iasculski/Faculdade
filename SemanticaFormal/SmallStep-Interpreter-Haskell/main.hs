

data E = Num Int
      |Var String
      |Soma E E
      |Sub E E
      |Mult E E
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
    | DuplaAtrib E E E E
    | AtribCond B E E E
    | Swap E E
   deriving(Eq,Show)

type Memoria = [(String,Int)]

exSigma :: Memoria
exSigma = [ ("x", 10), ("temp",0), ("y",0)]

procuraVar :: Memoria -> String -> Int
procuraVar [] s = error ("Variavel " ++ s ++ " nao definida no estado")
procuraVar ((s,i):xs) v
  | s == v     = i
  | otherwise  = procuraVar xs v

mudaVar :: Memoria -> String -> Int -> Memoria
mudaVar [] v n = error ("Variavel " ++ v ++ " nao definida no estado")
mudaVar ((s,i):xs) v n
  | s == v     = ((s,n):xs)
  | otherwise  = (s,i): mudaVar xs v n
-----------------------------------------------------------------------------------------------------
---Expressões Aritméticas
-----------------------------------------------------------------------------------------------------
smallStepE :: (E, Memoria) -> (E, Memoria)
smallStepE (Var x, s)                  = (Num (procuraVar s x), s)

smallStepE (Soma (Num n1) (Num n2), s) = (Num (n1 + n2), s)
smallStepE (Soma (Num n) e, s)         = let (el,sl) = smallStepE (e,s)  in (Soma (Num n) el, sl)
smallStepE (Soma e1 e2,s)              = let (el,sl) = smallStepE (e1,s) in (Soma el e2,sl)

smallStepE (Mult (Num n1) (Num n2), s) = (Num (n1 * n2), s)
smallStepE (Mult (Num n) e, s)         = let (el,sl) = smallStepE (e,s)  in (Mult (Num n) el, sl)
smallStepE (Mult e1 e2,s)              = let (el,sl) = smallStepE (e1,s) in (Mult el e2,sl)

smallStepE (Sub (Num n1) (Num n2),s)   = (Num (n1 - n2),s)
smallStepE (Sub (Num n) e,s)           = let (el,sl) = smallStepE (e,s)  in (Sub (Num n) el, sl)
smallStepE (Sub e1 e2,s)               = let (el,sl) = smallStepE (e1,s) in (Sub el e2, sl)

-----------------------------------------------------------------------------------------------------
---Expressões Booleanas
-----------------------------------------------------------------------------------------------------
smallStepB :: (B,Memoria) -> (B, Memoria)

smallStepB (Not TRUE,s)     = (FALSE,s)
smallStepB (Not FALSE,s)    = (TRUE,s)
smallStepB (Not b,s)        = let (bl,sl) = smallStepB(b,s) in (Not bl,sl)

smallStepB (And TRUE b2,s)  = (b2,s)
smallStepB (And FALSE b2,s) = (FALSE,s)
smallStepB (And b1 b2,s)    = let(bl,sl) = smallStepB(b1,s) in (And bl b2,s)

smallStepB (Or TRUE b2,s )  = (TRUE,s)
smallStepB (Or FALSE b2,s ) = (b2,s)
smallStepB (Or b1 b2,s )    = let(bl,sl) = smallStepB(b1,s) in (Or bl b2,s)

smallStepB (Leq (Num n1) (Num n2), s)
 | (n1 <= n2) = (TRUE,s)
 | otherwise  = (FALSE,s)
smallStepB (Leq (Num n1) e2, s)   = let(el,sl) = smallStepE(e2,s) in (Leq (Num n1) el,sl)
smallStepB (Leq e1 e2, s)         = let(el,sl) = smallStepE(e1,s) in (Leq el e2,sl)

smallStepB (Igual (Num n1) (Num n2), s)
 | (n1 == n2)  = (TRUE,s)
 | otherwise = (FALSE,s)
smallStepB (Igual (Num n) e, s)   = let(el,sl) = smallStepE(e,s)  in (Igual (Num n) el,sl)
smallStepB (Igual e1 e2, s)       = let(el,sl) = smallStepE(e1,s) in (Igual el e2,s)

-----------------------------------------------------------------------------------------------------
---Expressões de Comando
-----------------------------------------------------------------------------------------------------
smallStepC :: (C,Memoria) -> (C,Memoria)
smallStepC (If TRUE c1 c2,s)   = (c1,s)
smallStepC (If FALSE c1 c2,s)  = (c2,s)
smallStepC (If b c1 c2,s)      = let(bl,sl) = smallStepB(b,s) in (If bl c1 c2,sl)

smallStepC (Seq Skip c2,s)     = (c2,s)
smallStepC (Seq c1 c2,s)       = let(cl,sl) = smallStepC(c1,s) in (Seq cl c2,sl)

smallStepC (Atrib (Var x) (Num n),s) = (Skip,mudaVar s x n)
smallStepC (Atrib (Var x) e,s)       = let(el,sl) = smallStepE(e,s) in (Atrib(Var x) el,sl)
smallStepC (While b c, s)   = (If b (Seq c (While b c)) Skip,s)
smallStepC (TenTimes c,s)   = (Loop (Num 0)(Num 10) c,s) 
smallStepC (Repeat c b,s)   = (Seq c (While (Not b) c),s)
smallStepC (Loop e1 e2 c,s) = (If (Leq e1 e2) (Seq c (Loop e1 (Sub e2 (Num 1)) c)) Skip,s)
smallStepC (DuplaAtrib (Var x)(Var y) e1 e2,s) = (Seq (Atrib (Var x) e1)(Atrib (Var y) e2),s)
smallStepC (AtribCond b (Var x) e1 e2,s) = (If b (Atrib (Var x) e1)(Atrib (Var x) e2),s)
smallStepC (Swap (Var x)(Var y),s) = (Seq (Atrib(Var "z")(Var x))(DuplaAtrib(Var x)(Var y)(Var y)(Var"z")),s)

-----------------------------------------------------------------------------------------------------
---Interpretador para Expressões Aritméticas
-----------------------------------------------------------------------------------------------------
isFinalE :: E -> Bool
isFinalE (Num n) = True
isFinalE _       = False

interpretadorE :: (E,Memoria) -> (E, Memoria)
interpretadorE (e,s) = if (isFinalE e) then (e,s) else interpretadorE (smallStepE (e,s))

-----------------------------------------------------------------------------------------------------
---Interpretador para Expressões Booleanas
-----------------------------------------------------------------------------------------------------
isFinalB :: B -> Bool
isFinalB TRUE    = True
isFinalB FALSE   = True
isFinalB _       = False

interpretadorB :: (B,Memoria) -> (B, Memoria)
interpretadorB (b,s) = if (isFinalB b) then (b,s) else interpretadorB (smallStepB (b,s))

-----------------------------------------------------------------------------------------------------
---Interpretador para Comandos
-----------------------------------------------------------------------------------------------------
isFinalC :: C -> Bool
isFinalC Skip    = True
isFinalC _       = False

interpretadorC :: (C,Memoria) -> (C, Memoria)
interpretadorC (c,s) = if (isFinalC c) then (c,s) else interpretadorC (smallStepC (c,s))

----------------------------------------------------------------------------------------------------
---Testes
----------------------------------------------------------------------------------------------------
exSigma2 :: Memoria
exSigma2 = [("x",3), ("y",0), ("z",0)]

progExp1 :: E
progExp1 = Soma (Num 3) (Soma (Var "x") (Var "y"))

teste1 :: B
teste1 = (Leq (Soma (Num 3) (Num 3))  (Mult (Num 2) (Num 3)))

teste2 :: B
teste2 = (Leq (Soma (Var "x") (Num 3))  (Mult (Num 2) (Num 3)))

testec1 :: C
testec1 = (Seq (Seq (Atrib (Var "z") (Var "x")) (Atrib (Var "x") (Var "y"))) 
               (Atrib (Var "y") (Var "z")))
fatorial :: C
fatorial = (Seq (Atrib (Var "y") (Num 1))
                (While (Not (Igual (Var "x") (Num 1)))
                       (Seq (Atrib (Var "y") (Mult (Var "y") (Var "x")))
                            (Atrib (Var "x") (Sub (Var "x") (Num 1))))))
----------------------------------------------------------------------------------------------------
---Testes usando os interpretadores
----------------------------------------------------------------------------------------------------
