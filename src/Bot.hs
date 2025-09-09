module Bot
  ( Bot (..),
    testBot,
    sendMessage,
  )
where

import Relude

data Bot = Bot
  { name :: String
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