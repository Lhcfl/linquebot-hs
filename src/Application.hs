module Application (Application(..), runMainLoop) where

import Context
import Relude
import Bot
import BotJob
import AppConfig
import Lib (splitCommand)
import qualified Data.Text as T

data Application = MkApplication
  { jobs :: [BotJob],
    bot :: Bot
  }

runMainLoop :: AppConfig -> Application -> IO ()
runMainLoop cfg app = do
  -- Simulate processing a message
  msg <- getLine
  runJobs
    (jobs app)
    MkContext
      { bot = app.bot,
        botName = cfg.botName,
        message = msg,
        command = case T.uncons msg of
          Just ('/', args) -> Just (splitCommand args)
          _ -> Nothing
      }
  runMainLoop cfg app

