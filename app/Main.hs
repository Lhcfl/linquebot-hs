module Main (main) where

import AppConfig
import Application
import Bot
import BotJob
import Greeting (sayHi)
import qualified Jobs.Echo (echojob)
import qualified Jobs.Rand (randjob)
import Relude

botJobs :: [BotJob]
botJobs =
  [ Jobs.Echo.echojob,
    Jobs.Rand.randjob
  ]

main :: IO ()
main = do
  sayHi
  config <- readAppConfigOrExit
  putTextLn $ "Config: " <> show config
  runMainLoop
    config
    MkApplication
      { jobs = botJobs,
        bot = testBot config.botName
      }