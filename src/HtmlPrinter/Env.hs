module HtmlPrinter.Env where

data Env = Env
  { eBlogName :: String,
    eStylesheetPath :: FilePath
  }
  deriving (Show)

defaultEnv :: Env
defaultEnv = Env "html printer" "style.css"