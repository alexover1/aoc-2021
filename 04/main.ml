let file = "input.txt"
let axis_size = 5
let board_size = axis_size * axis_size

let column (board: 'a array array) (c: int) : 'a array =
    Array.init axis_size (fun i -> board.(i).(c))

let columns(board: 'a array array) : 'a array array =
    Array.init axis_size (fun i -> Array.init axis_size (fun j -> board.(j).(i)))

class board_type =
    object (self)
        val mutable board = (Array.make_matrix axis_size axis_size 0 : int array array)
        val mutable marks = (Array.make_matrix axis_size axis_size false : bool array array)
        val mutable my_index = (0 : int)
        method get_board = board
        method push_row (xs: int array) =
            board.(my_index) <- xs;
            my_index <- my_index + 1
        method mark x y =
            marks.(y).(x) <- true
        method mark_if_has (n: int) =
            for x = 0 to axis_size-1 do
                for y = 0 to axis_size-1 do
                    if board.(y).(x) == n then
                        self#mark x y
                done;
            done;
        method bingo_col col =
            Array.for_all (fun e -> e) col
        method bingo_row row =
            Array.for_all (fun e -> e) row
        method bingo =
            Array.exists self#bingo_row marks ||
                Array.exists self#bingo_col (columns marks)
        method sum =
            let sum = ref 0 in
            for y = 0 to axis_size-1 do
                for x = 0 to axis_size-1 do
                    if not marks.(y).(x) then sum := !sum + board.(y).(x)
                done;
            done;
            !sum
    end;;

let read_board ic =
    let board = new board_type in
    for i = 1 to 5 do
        let row = input_line ic
            |> String.split_on_char ' '
            |> List.filter (fun s -> s <> "")
            |> List.map (fun s -> int_of_string s)
            |> Array.of_list
        in
        board#push_row row
    done; board;;

let read_boards filename : (int array * board_type list) =
    let numbers = ref [||] in
    let boards = ref [] in
    let chan = open_in filename in
    try
        numbers := input_line chan 
            |> String.split_on_char ','
            |> List.filter (fun s -> s <> "")
            |> List.map (fun s -> int_of_string s)
            |> Array.of_list;
        ignore (input_line chan);
        
        while true; do
            boards := read_board chan :: !boards;
            ignore (input_line chan);
        done; (!numbers, !boards)
    with End_of_file ->
        close_in chan;
        (!numbers, List.rev !boards);;

let draw_number (boards: board_type list) (n: int) =
    let f board = board#mark_if_has n in
    List.iter f boards;;

let part_one =
    let numbers, boards = read_boards file in
    let next_state n =
        draw_number boards n;
        try
            (List.find (fun board -> board#bingo) boards)#sum
        with Not_found -> (-1)
    in
    let rec solve a d =
        if d != -1 then d * numbers.(a-1)
        else solve (a+1) (next_state numbers.(a))
    in
    let result = solve 0 (-1) in
    Printf.printf "Part One: %d\n" result;;

let () =
    part_one;;
