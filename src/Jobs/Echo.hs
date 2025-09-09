module Jobs.Echo (echojob) where

import Bot
import BotJob
import Context
import Relude

echojob :: BotJob
echojob = do
  context <- ask
  case command context of
    Just ("echo", text) -> do
      liftIO $ sendMessage text context.bot
      return NextJob
    _ -> return NextJob