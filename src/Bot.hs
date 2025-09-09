module Bot
  ( Application (..),
    Bot (..),
    BotJob,
    BotJobResult (..),
    Context (..),
    runbot,
    sendMessage,
  )
where

import qualified App (AppConfig (botName))
import qualified Data.Text as T
import Lib (splitCommand)
import Relude

data BotJobResult
  = StopHere
  | NextJob

data Context = Context
  { botName :: String,
    message :: Text,
    command :: Maybe (Text, Text), -- (command, args)
    bot :: Bot
  }

type BotJob = ReaderT Context IO BotJobResult

data Bot = Bot
  { name :: String
  }

data Application = Application
  { jobs :: [BotJob]
  }

testBot :: String -> Bot
testBot bname =
  Bot
    { name = bname
    }

sendMessage :: Text -> Bot -> IO ()
sendMessage msg b = do
  putStr $ "[" ++ name b ++ "]: "
  putTextLn msg

runbot :: App.AppConfig -> Application -> IO ()
runbot cfg app = do
  -- Simulate processing a message
  msg <- getLine
  runJobs
    (jobs app)
    Context
      { bot = testBot (App.botName cfg),
        botName = App.botName cfg,
        message = msg,
        command = case T.uncons msg of
          Just ('/', args) -> Just (splitCommand args)
          _ -> Nothing
      }
  runbot cfg app

runJobs :: [BotJob] -> Context -> IO ()
runJobs [] _ = return ()
runJobs (x : xs) ctx = do
  result <- runReaderT x ctx
  case result of
    StopHere -> putStrLn "Task Stopped."
    NextJob -> runJobs xs ctx
