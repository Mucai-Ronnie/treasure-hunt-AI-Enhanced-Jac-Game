# Implementation of the Hunter walker abilities

impl Hunter.start_game {
    self.current_node = entry;
    print("Welcome to Treasure Hunt (AI-enabled)!");
    print(f"You have {self.moves} moves. Commands: move <room>, inspect, hint, quit.");

    while self.moves > 0 and not self.found {
        print(f"\nYou are in the {self.current_node.name}.");
        print("Exits: " + ", ".join(self.current_node.neighbors));

        cmd = input("Enter command: ").strip().lower();

        if cmd == "quit" {
            print("Bye!");
            return;
        } else if cmd.startswith("move ") {
            dest = cmd.split(" ", 1)[1];
            moved = False;

            visit [-->] as neighbor {
                if neighbor.name == dest {
                    self.current_node = neighbor;
                    print("You move to " + dest);
                    moved = True;
                }
            };

            if not moved {
                print("You can't move there from here.");
            }

        } else if cmd == "inspect" {
            if self.current_node.has_treasure {
                print("🎉 You found the treasure! Congratulations!");
                self.found = True;
                disengage;
                return;
            } else {
                print("No treasure here.");
            }

        } else if cmd == "hint" {
            distance_hint = "far";

            for nname in self.current_node.neighbors {
                visit [-->] as neigh {
                    if neigh.name == nname and neigh.has_treasure {
                        distance_hint = "very near";
                    }
                };
            }

            hint_text = generate_hint(self.current_node.description, distance_hint);
            print("Hint: " + hint_text);

        } else {
            print("Unknown command.");
        }

        self.moves -= 1;
        if self.moves > 0 {
            print("Moves left: " + str(self.moves));
        }
    }

    if not self.found {
        visit [-->] as t {
            if t.has_treasure {
                print("Out of moves! The treasure was in: " + t.name);
            }
        };
    }
}

// Implementation of the byLLM-backed helper
def generate_hint(room_desc: str, distance_hint: str) -> str by llm() {
    return f"In this {room_desc} you sense a whisper of something {distance_hint}; the air itself nudges you closer.";
}
