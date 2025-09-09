module Lib
  ( splitCommand,
  )
where

import Data.Char (isSpace)
import Data.Text (findIndex, splitAt)
import Relude hiding (splitAt)

splitCommand :: Text -> (Text, Text)
splitCommand input =
  -- we can safely use 9999 here because commands are never that long
  splitAt (fromMaybe 9999 firstSpaceIndex) input
  where
    firstSpaceIndex = findIndex isSpace input
