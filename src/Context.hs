module Context (Context (..)) where

import Bot
import Relude

data Context = MkContext
  { botName :: String,
    message :: Text,
    command :: Maybe (Text, Text), -- (command, args)
    bot :: Bot
  }
