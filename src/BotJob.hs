module BotJob (BotJob, BotJobResult (..), runJobs) where

import Context
import Relude

data BotJobResult
  = StopHere
  | NextJob

type BotJob = ReaderT Context IO BotJobResult

runJobs :: [BotJob] -> Context -> IO ()
runJobs [] _ = return ()
runJobs (x : xs) ctx = do
  result <- runReaderT x ctx
  case result of
    StopHere -> putStrLn "Task Stopped."
    NextJob -> runJobs xs ctx