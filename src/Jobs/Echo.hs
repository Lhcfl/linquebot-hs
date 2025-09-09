module Jobs.Echo (echojob) where

import BotJob
import Bot
import Relude
import Context

echojob :: BotJob
echojob = do
  context <- ask
  case command context of
    Just ("echo", text) -> do
      liftIO $ sendMessage text context.bot
      return NextJob
    _ -> return NextJob