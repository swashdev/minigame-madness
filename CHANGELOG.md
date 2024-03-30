# Changelog

This is the changelog for Minigame Madness.  All noteworthy changes to the game
will be documented in this file.

This changelog follows the
[Keep a Changelog version 1.0.0](https://keepachangelog.com/en/1.0.0/)
convention.  
Minigame Madness _does not_ use Semantic Versioning.


## [UNRELEASED]

### Fixed

- A bug existed in the code which allowed the player to attempt to quit before
  the game has begun, causing the game to try to clear data that doesn't exist.
  This update should have fixed that.

- The spawn rules for the pizzas in the "Don't Get Pizza'd!" minigame have been
  overhauled so that the pizzas will consistently appear at a fair distance
  away from the player.

### Changed

- The "sky" texture used in several minigames is now imported with a lossless
  compression method, substantially improving its appearance.

- The cheat code to open the debug menu has been changed.

- The "Hit a Home Run!" minigame has been made more forgiving.  It is now
  substantially easier to hit a home run.

- The hit boxes in the "Don't Get Pizza'd!" minigame have been tweaked very
  slightly to align with their sprites.  This probably won't have a noticeable
  impact on gameplay.

- The pizzas in the "Don't Get Pizza'd!" minigame can now move farther off of
  the screen before wrapping around, making them easier to dodge.

### Added

- A brand-new minigame: "Defend!" (legally distinct from Pong)


## [0.13.5] - 2024-03-28

### Fixed

- Pressing button 1 on a controller will no longer exit the game.  Instead,
  this function has been assigned to the Select button and the Escape key.
  Button 1 is still used to navigate backwards in menus and close dialogs.

- The missile in the "Shoot Five!" minigame is now only removed after the
  player's death if it has not yet been fired, removing a bug which could cause
  crashes.  If the missile has been fired by the time the player dies, it will
  now continue on its course until detonation, as normal.

### Added

- The "Don't Get Pizza'd!" minigame now has a starry background!

- There is now a slide in the Controls menu explaining the controller
  mappings.


## [0.13.4] - 2024-03-23

### Changed

- The version number disclosure in the main menu now says that the game is
  "running" on a particular Godot version, rather than "built" on it.

- The version number disclosure now specifies whether the game is running on
  a debug build of Godot.

- The vine in the "Get Across!" minigame now moves twice as fast, to provide
  players with extra opportunities to get across if they miss the first vine.
  The duck's speed is unmodified.

- Indiana Jumpman's hat is now a darker shade of brown, so that it doesn't
  blend in with the background graphics too much.

- Joypad button 1 can now be used in addition to button 0 for the "action"
  button in minigames.

### Fixed

- The player can now only grab the vine in the "Get Across!" minigame once.
  This is to prevent the vine from "catching" the player after they try to
  jump across the pit, which can kill some runs.

- The assets in the "Get Across!" minigame now use a darker green color, to
  make certain obstacles more visible on some monitors.

- The left and right buttons on the Controls menu no longer have tooltips.

- The player now destroys pizzas on colliding with them in the "Don't Get
  Pizza'd!" minigame.  This does not prevent the player from dying.

- The pizzas in the "Don't Get Pizza'd!" minigame now check for collisions
  while moving rather than "sliding."  If they detect a collision, they will
  self-destruct and check if the entity they hit is the player.


## [0.13.3] - 2024-03-17

### Changed

- Updated to Godot Engine 3.5.3-stable.

### Corrections

- In version 0.13.1, some source files were moved around in order to be more
  compliant with standard practice for Godot projects, but relevant licensing
  documentation was updated incompletely.  The documentation in the LICENSE
  file was corrected with this version.


## [0.13.2-hotfix] - 2024-01-14 [YANKED]

### Fixed

- Implemented a bugfix from an archived version of the repository.  This fix
  prevents the "Shoot Five!" minigame from causing crashes by attempting to
  do work with the player node after it has been removed due to the player's
  ship being destroyed.


## [0.13.1] - 2024-01-11 [YANKED]

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
