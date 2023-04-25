import Data.Maybe (listToMaybe, maybeToList)
import Data.Word (Word8)
import HtmlPrinter.Markup

replicate_ :: Int -> a -> [a]
replicate_ size elm =
  if size <= 0
    then []
    else elm : replicate_ (size - 1) elm

even_ :: Int -> Bool
even_ n =
  if n == 0
    then True
    else odd (n - 1)

odd_ :: Int -> Bool
odd_ n =
  if n == 0
    then False
    else even_ (n - 1)

-- parse :: String -> Document
-- parse = parseLines [] . lines -- (1)

-- parseLines :: [String] -> [String] -> Document
-- parseLines currentParagraph txts =
--   let paragraph = Paragraph (unlines (reverse currentParagraph)) -- (2), (3)
--    in case txts of -- (4)
--         [] -> [paragraph]
--         currentLine : rest ->
--           if trim currentLine == ""
--             then paragraph : parseLines [] rest -- (5)
--             else parseLines (currentLine : currentParagraph) rest -- (6)

-- trim :: String -> String
-- trim = unwords . words

safeHead :: [a] -> Maybe a
safeHead list =
  case list of
    -- Empty list
    [] -> Nothing
    -- Cons cell pattern, will match any list with at least one element
    x : _ -> Just x

exactlyTwo :: [a] -> Maybe (a, a)
exactlyTwo list =
  case list of
    -- Will match a list with exactly two elements
    [x, y] -> Just (x, y)
    -- Will match any other pattern
    _ -> Nothing

-- This will also work
exactlyTwoVersion2 :: [a] -> Maybe (a, a)
exactlyTwoVersion2 list =
  case list of
    -- Will match a list with exactly two elements
    x : y : [] -> Just (x, y)
    -- Will match any other pattern
    _ -> Nothing

data Brightness
  = Dark
  | Bright

data EightColor
  = Black
  | Red
  | Green
  | Yellow
  | Blue
  | Magenta
  | Cyan
  | White

data AnsiColor
  = AnsiColor Brightness EightColor

-- | A data type representing colors
data Color
  = RGB Word8 Word8 Word8

getBluePart :: Color -> Word8
getBluePart color =
  case color of
    RGB _ _ blue -> blue

ansiColorToVGA :: AnsiColor -> Color
ansiColorToVGA ansicolor =
  case ansicolor of
    AnsiColor Dark Black ->
      RGB 0 0 0
    AnsiColor Bright Black ->
      RGB 85 85 85
    AnsiColor Dark Red ->
      RGB 170 0 0
    AnsiColor Bright Red ->
      RGB 255 85 85

-- and so on

isBright :: AnsiColor -> Bool
isBright ansicolor =
  case ansicolor of
    AnsiColor Dark _ ->
      False
    AnsiColor Bright _ ->
      True

ansiToUbuntu :: AnsiColor -> Color
ansiToUbuntu ansiColor =
  case ansiColor of
    AnsiColor brightness color ->
      case brightness of
        Dark ->
          case color of
            Black -> RGB 0 0 0
            Red -> RGB 194 54 33
            Green -> RGB 37 188 36
            Yellow -> RGB 173 173 39
            Blue -> RGB 73 46 225
            Magenta -> RGB 211 56 211
            Cyan -> RGB 51 187 200
            White -> RGB 203 204 205
        Bright ->
          case color of
            Black -> RGB 129 131 131
            Red -> RGB 252 57 31
            Green -> RGB 49 231 34
            Yellow -> RGB 234 236 35
            Blue -> RGB 88 51 255
            Magenta -> RGB 249 53 248
            Cyan -> RGB 20 240 240
            White -> RGB 233 235 235

isEmpty :: [a] -> Bool
isEmpty list =
  case listToMaybe list of
    Nothing -> True
    Just _ -> False

isEmpty_ :: [a] -> Bool
isEmpty_ list =
  case list of
    [] -> True
    _ : _ -> False

confirm :: IO Bool
confirm =
  putStrLn "Are you sure? (y/n)"
    *> getLine
    >>= \answer ->
      case answer of
        "y" -> pure True
        "n" -> pure False
        _ ->
          putStrLn "Invalid response. use y or n"
            *> confirm

greeting :: IO ()
greeting = do
  putStrLn "Tell me your name."
  let greet name = "Hello, " ++ name ++ "!"
  name <- getLine
  putStrLn (greet name)

-- greeting :: IO ()
-- greeting =
--   putStrLn "Tell me your name." *>
--     let
--       greet name = "Hello, " ++ name ++ "!"
--     in
--       getLine >>= \name ->
--         putStrLn (greet name)
