module Main (main) where

import App (readAppConfigOrExit)
import Bot
import Greeting (sayHi)
import qualified Jobs.Echo (echojob)
import qualified Jobs.Rand (randjob)
import Relude

main :: IO ()
main = do
  sayHi
  config <- readAppConfigOrExit
  putStrLn $ "Config: " <> show config
  runbot
    config
    Application
      { jobs =
          [ Jobs.Echo.echojob,
            Jobs.Rand.randjob
          ]
      }