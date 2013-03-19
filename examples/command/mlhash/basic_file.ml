open Core.Std

let get_file_data file =
  In_channel.read_all file
 
let do_hash file =
  let open Cryptokit in
  get_file_data file 
  |> hash_string (Hash.md5 ())
  |> transform_string (Hexa.encode ())
  |> print_endline

let command =
  Command.basic
    ~summary:"Generate an MD5 hash of the input data"
    Command.Spec.(
      empty
      +> anon ("filename" %: file)
    )
  (fun file () -> do_hash file)

let () = Command.run command
