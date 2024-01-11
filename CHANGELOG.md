# Changelog

This is the changelog for Minigame Madness.  All noteworthy changes to the game
will be documented in this file.

This changelog follows the
[Keep a Changelog version 1.0.0](https://keepachangelog.com/en/1.0.0/)
convention.  
Minigame Madness _does not_ use Semantic Versioning.


## [UNRELEASED]

### Changed

- A new singleton, `Global`, will be used from here on out to store global
  variables and utility functions.  In this inaugural update of this feature,
  the following features will be stored in `Global`:

  - The `GameMode` enum, which defines which "game mode" (debug, normal,
    endurance, &c) is available.

  - The `WON`, `LOST`, and `CANCELLED` enums, which are used to specify why the
    game has ended.  (now stored in the `Global.GameOver` enum)

- The values of `GameMode.NORMAL` and `GameMode.DEBUG` have been swapped.

- The values of `GameOver.WON`, `GameOver.LOST`, and `GameOver.CANCELLED` have
  been moved around to `1`, `2`, and `0`, respectively.

- A new singleton, `Version`, will be used from here on out to store
  the game's version number and information relevant to it, including how to
  convert it to a string.

- Moved functions to display the version number into `MainMenu` where it
  belongs.

- The player character in the "Shoot Five!" minigame now collides with enemies.

- Third-party assets have been moved to appropriate folders in the "assets"
  directory.

- The `Version.AS_HEX` constant has been removed for having no conceivable
  purpose.


## [0.13] - 2022-04-20

### Added

- The version number label on the main menu will now display the version number
  for the version of the Godot Engine that was used to build Minigame Madness.

- New minigame: Dance, Dance, Dance!

- A SConstruct profile used to compile an optimal version of the Godot Engine
  for Minigame Madness exports is now available in custom.py.

### Changed

- Minigames in the Debug menu are now listed by title rather than number.

### Deprecated

- The version number "types," i.e. "Pre-Release," "Alpha," and "Beta" have been
  deprecated.  For the time being, Minigame Madness will now simply use its own
  version number without additional unnecessary fluff.
