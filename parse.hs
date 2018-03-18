
import System.IO
import System.Environment
import Data.List
import Data.Char
import Text.Show.Unicode

type Script   = [Scene]
data Scene    =  Scene   {title :: String,
                          pref  :: Content,
                          subs  :: SubScenes}

newtype SubScenes = SubScenes {getSubScenes :: [SubScene]}

data SubScene = SubScene {name  :: String, ctnt :: Content}

data Content  = Content  {sents :: [String], opts :: [Option]}

data Option   = Option   {tag   :: String, sent :: String}

instance Show Scene where
  show (Scene t p s) =
    "{title:" ++ ushow t ++
      ",pref:" ++ show p ++
        ",subs:" ++ show s ++ "}"

instance Show SubScenes where
  show (SubScenes ss) = "{" ++
    (intercalate "," $ map show ss) ++ "}"

instance Show SubScene where
  show (SubScene n c) =
    ushow n ++ ":" ++ show c


instance Show Content where
  show (Content ss os) =
    "{sents:" ++ ushow ss ++
      ",opts:" ++ show os ++ "}"

instance Show Option where
  show (Option t s) =
    "{tag:" ++ ushow t ++
      ",sent:" ++ ushow s ++ "}"

sceneMrk = "# "
subscMrk = "## "
insMrk   = "<!--insert here-->"
optMrk   = ':'

parseOption opt
  | optMrk `elem` opt =
    let (tag, stat) = break (== optMrk) opt in
        Option tag $ tail stat
  | otherwise = error "parse option without colon"

parseCont ct =
  let (sts, opts) = break (elem optMrk) ct in
      Content (reverse sts) $ map parseOption opts

parseSubsc [] = error "parse subsc with nil"
parseSubsc (x:xs)
  | isPrefixOf subscMrk x =
    SubScene (drop (length subscMrk) $ x) (parseCont xs)
  | otherwise = error "parse scene without title"

parseScene [] = error "parse scene with nil"
parseScene (x:xs)
  | isPrefixOf sceneMrk x =
    let (p, s) = break (isPrefixOf subscMrk) xs
        tit = (drop (length sceneMrk) $ x)
        scCont = parseCont p
        scSubscs = map parseSubsc $ splitWith subscMrk s
     in Scene tit scCont $ SubScenes scSubscs
  | otherwise = error "parse scene without title"

splitWith mrk xs = let
        ss [] [] [] = []
        ss rtn acc [] = reverse acc:rtn
        ss rtn acc (x:xs)
          | null acc = ss rtn (x:acc) xs
          | isPrefixOf mrk x = ss (reverse acc:rtn) [x] xs
          | otherwise = ss rtn (x:acc) xs in
        ss [] [] xs

parseScript raw =
  let ctx = filter ((>0) . length) . map strip $ lines raw
      script = map parseScene $ splitWith sceneMrk ctx
   in "<script>\nvar scs = " ++ show script ++ "\n</script>"

strip = f . f where f = reverse . dropWhile isSpace

main = do
  --args <- getArgs
  raw <- readFile "script.md"
  tml <- fmap lines $ readFile "tml.xml"
  let script = parseScript raw
      replace = (\t -> if isInfixOf insMrk t then script else t) in
    writeFile "output.html" . unlines $ map replace tml

