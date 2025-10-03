Treasure Hunt (AI-Enhanced with Jac)
This project is a **Jac language implementation** of a classic text-based game:
find the hidden treasure within a limited number of moves.  

It is based on a Python version and incrementally enhanced to use Jac's
object-spatial model. It demonstrates how the game could be extended
with AI-powered hints via `byLLM`.

## 🎮 How to Play

1. Run the game:
   ```bash
   jac run treasure_hunt6.jac

Available commands:

move <room> → move to a connected room

inspect → check the room for treasure

hint → get a clue (AI-powered if byLLM is configured, otherwise a basic hint)

quit → exit the game.

You have 8 moves to find the treasure.
