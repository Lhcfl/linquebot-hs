module Application (Application (..), runMainLoop) where

import AppConfig
import Bot
import BotJob
import Context
import qualified Data.Text as T
import Lib (splitCommand)
import Relude

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
