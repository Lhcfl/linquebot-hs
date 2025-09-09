{-# LANGUAGE QuasiQuotes #-}

module Greeting (sayHi) where

import Data.Version (showVersion)
import Paths_linquebot_hs (version)
import Rainbow (blue, fore, putChunkLn)
import Relude
import Text.RawString.QQ

linquebot :: Text
linquebot =
  [r|
 _     _                        _           _   
| |   (_)_ __   __ _ _   _  ___| |__   ___ | |_ 
| |   | | '_ \ / _` | | | |/ _ \ '_ \ / _ \| __|
| |___| | | | | (_| | |_| |  __/ |_) | (_) | |_ 
|_____|_|_| |_|\__, |\__,_|\___|_.__/ \___/ \__|
| | | | __ _ ___| |_|____| | |
| |_| |/ _` / __| |/ / _ \ | |
|  _  | (_| \__ \   <  __/ | |
|_| |_|\__,_|___/_|\_\___|_|_| |]

sayHi :: IO ()
sayHi = do
  putText $ linquebot
  putChunkLn $ fore blue $ fromString $ "version: " <> showVersion version
