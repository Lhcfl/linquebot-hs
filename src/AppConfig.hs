{-# LANGUAGE NoImplicitPrelude #-}

module AppConfig
  ( readAppConfig,
    readAppConfigOrExit,
    AppConfig (..),
    AppInitError (..),
  )
where

import Control.Monad.Except (throwError)
import Rainbow (blue, fore, putChunk, putChunkLn, red)
import Relude
import System.Environment.Blank (getEnvDefault)
import qualified Text.Show

data AppConfig = AppConfig
  { botToken :: String,
    botName :: String
  }
  deriving (Show)

data AppInitError = MissingEnvVar String

instance Show AppInitError where
  show (MissingEnvVar var) = "Environment variable " ++ show var ++ " is missing."

readAppConfig :: ExceptT AppInitError IO AppConfig
readAppConfig = do
  token <- lift (lookupEnv "BOT_TOKEN") >>= maybe (throwError $ MissingEnvVar "BOT_TOKEN") return
  name <- lift (getEnvDefault "BOT_NAME" "Linquebot")
  return $ AppConfig {botToken = token, botName = name}

-- | Reads the application configuration, exiting the program if there is an error.
readAppConfigOrExit :: IO AppConfig
readAppConfigOrExit = do
  result <- runExceptT readAppConfig
  case result of
    Left err -> do
      putChunkLn $ "========= APP CONFIG ERROR ========" & fore blue
      putChunk $ "fatal error: " & fore red
      putStrLn $ show err
      exitFailure
    Right config -> return config