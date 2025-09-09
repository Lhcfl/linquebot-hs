module Jobs.Rand (randjob) where

import Bot
import Relude
import System.Random

randjob :: BotJob
randjob = do
  context <- ask
  case command context of
    Just ("rand", text) -> liftIO $ do
      rp <- randomRIO (1, 100 :: Int)
      context
        & bot
        & sendMessage
          ( if text == ""
              then "你抛出了：" <> show rp
              else "你 " <> text <> " 的概率是: " <> show rp <> "%"
          )

      return NextJob
    _ -> return NextJob