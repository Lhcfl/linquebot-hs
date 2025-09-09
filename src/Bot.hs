module Bot
  ( Bot (..),
    testBot,
    sendMessage,
  )
where

import Relude

data Bot = Bot
  { name :: Text
  }

testBot :: Text -> Bot
testBot bname =
  Bot
    { name = bname
    }

sendMessage :: Text -> Bot -> IO ()
sendMessage msg b = putTextLn $ "[" <> b.name <> "]: " <> msg