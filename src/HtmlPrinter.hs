-- HsBlog.hs
module HtmlPrinter
  ( convertSingle,
    process,
    convertDirectory,
    buildIndex,
  )
where

import HtmlPrinter.Convert (convert)
import HtmlPrinter.Directory
import HtmlPrinter.Env (defaultEnv)
import qualified HtmlPrinter.Html as Html
import qualified HtmlPrinter.Markup as Markup
import System.IO

convertSingle :: String -> Handle -> Handle -> IO ()
convertSingle title input output = do
  content <- hGetContents input
  hPutStrLn output (process title content)

process :: String -> String -> String
process title = Html.render . convert defaultEnv title . Markup.parse
