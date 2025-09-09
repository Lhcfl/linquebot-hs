module Jobs.Echo (echojob) where

import Bot
import Relude

echojob :: BotJob
echojob = do
  context <- ask
  case command context of
    Just ("echo", text) -> do
      liftIO $ sendMessage text $ bot context
      return NextJob
    _ -> return NextJob