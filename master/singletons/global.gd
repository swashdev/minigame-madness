extends Node
# A singleton used to store global variables and utility functions.


# Game modes which can be chosen at game start.
enum GameMode { DEBUG, NORMAL, ENDURANCE, SUDDEN_DEATH }

# Reasons which the game might be over.
enum GameOver { CANCELLED, WON, LOST }
