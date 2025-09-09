module Lib
  ( splitCommand,
  )
where

import Data.Char (isSpace)
import Data.Text (findIndex, splitAt, stripStart)
import Relude hiding (splitAt)

splitCommand :: Text -> (Text, Text)
splitCommand input =
  (command, stripStart rest)
  where
    firstSpaceIndex = findIndex isSpace input
    -- we can safely use 9999 here because commands are never that long
    (command, rest) = splitAt (fromMaybe 9999 firstSpaceIndex) input
