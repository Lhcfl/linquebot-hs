module Context (Context(..)) where

import Relude
import Bot

data Context = MkContext
  { botName :: String,
    message :: Text,
    command :: Maybe (Text, Text), -- (command, args)
    bot :: Bot
  }
