module Context (Context (..)) where

import Bot
import Relude

data Context = MkContext
  { botName :: Text,
    message :: Text,
    command :: Maybe (Text, Text), -- (command, args)
    bot :: Bot
  }
