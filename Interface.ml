type 'a command =
| SHOW_FORMULA
| LET of string *  'a
| SEM of string * string list
| SAVE
| LOAD
| STOP_TEST
