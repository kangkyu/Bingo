module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trimRight)

-- Model

initalModel = {
   entries = [
     newEntry "Doing Agile" 200 2,
     newEntry "In the cloud" 300 3,
     newEntry "Future-Proof" 100 1,
     newEntry "Rock-Star Ninja" 400 4
   ]
  }

newEntry phrase points id =
  { phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }
-- Update

type Action
  = NoOp
  | Sort

update action model =
  case action of
    NoOp ->
      model

    Sort ->
      { model | entries <- List.sortBy .points model.entries }


-- View

title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trimRight
    |> text


pageHeader =
  h1 [ ] [title "bingo!" 3]


pageFooter =
  footer [ ]
    [ a [ href "https://ivanstorck.com"]
        [ text "by Ivan Storck" ] ]


entryItem entry =
  li [ ]
   [ span [ class "phrase" ] [ text entry.phrase ],
     span [ class "points" ] [ text (toString entry.points) ]
   ]


entryList entries =
  ul [ ] (List.map entryItem entries)


view model =
  div [ id "container" ]
   [ pageHeader,
     entryList model.entries,
     pageFooter ]


-- main
main =
--  view (update Sort initalModel)
  initalModel
    |> update Sort
    |> view
