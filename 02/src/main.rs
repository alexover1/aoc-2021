use std::fs;

static INPUT_PATH: &str = "./input.txt";

fn part_one(contents: &String) {
    let mut lines = contents.split("\n");

    let mut pos = 0;
    let mut depth = 0;

    while let Some(line) = lines.next() { if line != "" {
        let mut words = line.split(" ");
        let action = words.next().expect("Invalid puzzle input");
        let amount = words.next().expect("Invalid puzzle input")
            .to_string().parse::<i32>().unwrap();
        
        match action {
            "forward" => pos += amount,
            "down" => depth += amount,
            "up" => depth -= amount,
            _ => panic!("{}", action)
        }
    }}
    
    println!("Part One: {}", pos * depth);
}

fn part_two(contents: &String) {
    let mut lines = contents.split("\n");

    let mut pos = 0;
    let mut depth = 0;
    let mut aim = 0;

    while let Some(line) = lines.next() { if line != "" {
        let mut words = line.split(" ");
        let action = words.next().expect("Invalid puzzle input");
        let amount = words.next().expect("Invalid puzzle input")
            .to_string().parse::<i32>().unwrap();
        
        match action {
            "forward" => {
                pos += amount;
                depth += aim * amount;
            }
            "down" => aim += amount,
            "up" => aim -= amount,
            _ => panic!("{}", action)
        }
    }}
    
    println!("Part Two: {}", pos * depth);
}

fn main() {
    let contents = fs::read_to_string(INPUT_PATH)
        .expect("Something went wrong reading the file");
    part_one(&contents);
    part_two(&contents);
}
