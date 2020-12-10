import Data.List (groupBy, intercalate)

lookAndTell::String->String
lookAndTell n = intercalate "" [show(length x)++[head x] | x <- (groupBy (==) n)]

secuencia::String->[String]
secuencia x = x:(secuencia (lookAndTell x))

--take 10 (secuencia "1")
--["1","11","21","1211","111221","312211","13112221","1113213211","31131211131221","13211311123113112211"]