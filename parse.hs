
import System.IO
import Data.List
import Text.Show.Unicode

type Script   = [Scene]
data Scene    =  Scene   {title :: String,
                          pref  :: Content,
                          subs  :: [SubScene]}

data SubScene = SubScene {name  :: String, ctnt :: Content} deriving (Show)

data Content  = Content  {sents :: [String], opts :: [Option]} deriving (Show)

data Option   = Option   {tag   :: String, sent :: String} deriving (Show)

instance Show Scene where
  show (Scene tit prf sub) = ushow tit


sceneMrk = "# "
subscMrk = "## "

parseOption opt
  | ':' `elem` opt =
    let (tag, stat) = break (== ':') opt in
        Option tag $ tail stat
  | otherwise = error "parse option without colon"

parseCont ct =
  let (sts, opts) = break (elem ':') ct in
      Content sts $ map parseOption opts

parseSubsc [] = error "parse subsc with nil"
parseSubsc (x:xs)
  | isPrefixOf subscMrk x =
    SubScene (tail $ tail x) (parseCont xs)
  | otherwise = error "parse scene without title"

parseScene [] = error "parse scene with nil"
parseScene (x:xs)
  | isPrefixOf sceneMrk x =
    let (p, s) = break (isPrefixOf subscMrk) xs
        tit = tail $ tail x
        scCont = parseCont p
        scSubscs = map parseSubsc $ splitWith subscMrk s
     in Scene tit scCont scSubscs
  | otherwise = error "parse scene without title"

splitWith mrk xs = let
        ss [] [] [] = []
        ss rtn acc [] = reverse $ reverse acc:rtn
        ss rtn acc (x:xs)
          | null acc = ss rtn (x:acc) xs
          | isPrefixOf mrk x = ss (reverse acc:rtn) [x] xs
          | otherwise = ss rtn (x:acc) xs in
        ss [] [] xs

main = do
  raw <- readFile "script.txt"
  let ctx = filter ((>0) . length) $ lines raw
      script = map parseScene $ splitWith sceneMrk ctx
   in print script
