"""Treasure Hunt - Step 6 (AI-enhanced hints with byLLM)"""

import random;
from byllm.llm import { Model };

// configure a global LLM (choose model available in your environment)
glob llm = Model(model_name="gpt-4o", verbose=False);

walker Hunter {
    has moves: int = 8, found: bool = False;
    can start_game with `root entry;
}

node room {
    has name: str, neighbors: list, has_treasure: bool = False, description: str = "";
}

// a by-llm helper to generate a hint — typed to return a string
def generate_hint(room_desc: str, distance_hint: str) -> str by llm();

// Build map and spawn game
with entry:__main__ {
    entrance = node.room() set name="entrance", neighbors=["hall"], description="A modest doorway with a dust mat.";
    hall = node.room() set name="hall", neighbors=["entrance","kitchen","study"], description="A wide hall with old portraits.";
    kitchen = node.room() set name="kitchen", neighbors=["hall","pantry"], description="A kitchen with a faint smell of spices.";
    pantry = node.room() set name="pantry", neighbors=["kitchen"], description="Shelves with jars and boxes.";
    study = node.room() set name="study", neighbors=["hall","attic"], description="A quiet room filled with books.";
    attic = node.room() set name="attic", neighbors=["study"], description="A warm, dusty attic with trunks.";

    // connect rooms
    entrance ++> hall;
    hall ++> kitchen ++> pantry;
    hall ++> study ++> attic;

    // randomly place treasure
    rooms = [hall, kitchen, pantry, study, attic];
    idx = random.randint(0, len(rooms)-1);
    rooms[idx] set has_treasure=True;

    // start the game
    hunter = Hunter();
    hunter.start_game root;
}
