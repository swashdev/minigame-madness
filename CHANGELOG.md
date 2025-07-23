# Changelog

This is the changelog for Minigame Madness.  All noteworthy changes to the game
since version 0.13 will be documented in this file.

As of the release of version 0.15, this changelog _is not_ following the
[Keep a Changelog][Keep a Changelog] convention.  To find out why, please see
[this notice][new-changelog] from Minigame Madness's GitHub release notes.

Minigame Madness's version numbers are _not_ compliant with the
[Semantic Versioning][SemVer] standard.  To find out what the version numbers
mean, see the [Versioning System](#versioning-system) section at the bottom of
this document.

[Keep a Changelog]: https://keepachangelog.com/en/1.0.0
[new-changelog]: https://github.com/swashdev/minigame-madness/releases/tag/new-changelog
[SemVer]: https://semver.org/


## Unreleased - 2025-07-23

**Fixed**

- The background image in the "Bother the Cat!" minigame is now compressed
  properly.

**Changed**

Gameplay Changes:

- The anchovy's movement in "Don't Get Pizza'd!" has been changed to more
  closely resemble the movement mechanics in _Asteroid_.  
  To be slightly more technical, the player's movement is now independent of
  which direction the anchovy is facing &ndash; they will continue to move in
  a straight line without stopping until they change directions.  
  The player can still slow to a stop by pressing the "down" button.

- Braking is now given priority over acceleration in the "Don't Get Pizza'd!"
  minigame.  That is to say, if the player is pressing the UP and DOWN buttons
  simultaneously, the anchovy will slow to a stop.

Technical Changes:

- The "Get Across!" minigame, which previously made many many node access
  requests in its script, now stores references to its nodes in variables, to
  make it more programmatically efficient.

- The `pizza.gd` script in the "Don't Get Pizza'd!" minigame has been renamed
  to `pizza_slice.gd`, and the `half_pizza.gd` script has been renamed to
  `pizza.gd`, in order to be less confusing.  
  Additionally, the `Pizza` scene has been renamed to `QuarterPizza` so as not
  to be confused with the `WholePizza`, and its file name has been changed to
  `quarter_pizza.tscn`.


## Version 0.16 - 2025-07-22

**Added**

- A new minigame, "Bother the Cat!"

- Debug builds will now print what scene is being loaded while loading
  minigames, to help troubleshoot exports.

**Fixed**

- The collision shape on the right side of the pond in the "Get Across!"
  minigame no longer uses one-way collision.  This should prevent the player
  from falling through the floor during his victory animation.

- The "Get Across!" minigame is now pixelated properly.

**Changed**

- The ground in the "Get Across!" minigame now uses two shades of brown, to
  better communicate where the collision geometry is.  The blue in the pond
  has been adjusted so that it aesthetically matches this.

- The gators in the "Get Across!" minigame now start out already chomping, to
  help the player assess the timing of their chomps before the minigame has
  started.

- The probability of individual hazards coming up in the "Get Across!"
  minigame has been adjusted to make easier hazards come up more often.
  This started out of a desire to make the duck pond more of a surprise.

Technical Changes:

- The win state in the "Get Across!" minigame is now determined by the
  player's position, rather than an `Area2D` used to detect him.


## Version 0.15.1 - 2025-07-19

**Changed**

- The sky backgrounds &ndash; the blue sky and starry night sky &ndash; have
  been refactored to now inherit from `Node2D` instead of `Control`, and share
  in common the class `SkyBackground`.  This accomplishes two things:

    1. Reduces the number of occasions where the game relies on a `Control`
       where a `Node2D` would do just as well, and...

    2. Fixes a bug which caused the scrolling night sky in the "Jump!"
       minigame to not render properly on 32-bit builds (but weirdly not the
       ones that were built with LLVM).

- The "Legal Stuff" dialog has been split into two parts: One which gives a
  verbose explanation of Minigame Madness's licensing situation, and one which
  provides a detailed explanation of the licenses used by Minigame Madness and
  its dependencies.


## Version 0.15 - 2025-07-13

**Added**

- A new minigame, "Jump!"  Hop over the obstacles on your night run!

- A small surprise in the background of the "Dodge!" minigame.

**Changed**

- The number of lives the player is given at the beginning of the game has
  been increased from 3 to 5.

- The font size used by the message bar and in-game control prompts has been
  increased to be more readable on higher-resolution displays.

**Fixed**

- Fixed a syntax error in the `Version.get_nice_version()` function which
  prevented the function from appending patch numbers to the version number.


## Version 0.14\_2 - 2025-07-07

**Notes**

- Windows binaries have been renamed to "minigame-madness.exe" in order to
  match the naming scheme used by Linux and make it easier to drop in new
  data files after installing.

**Changed**

- The trains in the "Dodge!" minigame have been changed into cars, and the
  tracks into roads.

- The player and the evil cars in the "Dodge!" minigame now use proper physics
  movement, and the player now moves smoothly rather than snapping from one
  lane to another.

- The player in the "Dodge!" minigame is now animated &ndash; the car rotates
  as it moves.

- The score required to win the "Dance, Dance, Dance!" minigame has been
  greatly reduced.

- The progress bars in the "Dance, Dance, Dance!" minigame have been adjusted
  to try to encourage players to excel beyond the skill level needed to simply
  win.

- The night sky background, shared between a few minigames, now only accepts
  numbers of stars between 0 and 65,535 in the editor.  I believe it's
  theoretically possible to go higher using a script, but the setter has not
  been changed, so it is not possible to go lower than 0.

- The player character in the "Get to the Exit!" minigame has been changed.

- Jumping has been removed from the "Get to the Exit!" minigame.

**Removed**

- The main menu no longer displays the engine version it is running on.


## Version 0.14\_1 - Unreleased

**Added**

- There is now a volume slider on the main menu which can be used to change
  the music volume in-game.

**Fixed**

- Third-party assets are now stored in a folder named "addons," not "assets."
  The initial mistake was due to me misreading the documentation for standard
  project organization in Godot.

- Fluffy is now able to jump while on the ladder in the "Lose!" / "Get to the
  Exit!" minigame.

- Fluffy no longer flies off of the top of the ladder while climbing in the
  "Lose!" / "Get to the Exit!" minigame.

- It is now easier to get onto the cliffside from the ladder in the "Lose!" /
  "Get to the Exit!" minigame.

- Objects outside of the frame in the "Shoot Five!" minigame are no longer
  visible.

**Changed**

- The large explosion effect from the dragon missile in the "Shoot Five!"
  minigame now looks like a large explosion with a circular shape which
  matches its killing geometry.

- The game now exits early after displaying a help message for the
  "--debug-minigame" command.

- The "Lose!" minigame has been repurposed into a much more straightforward
  "Get to the Exit!" minigame.  This is being done due to persistent confusion
  as to the nature of the minigame, causing consistent player frustration.

- Rather than choosing a random hazard, only the spike in the cave is present
  in the "Lose!" / "Get to the Exit!" minigame.

    - The spike in the "Get to the Exit!" minigame now triggers when the player
      comes near, rather than on a timer, but visibly warns the player it is
      about to drop before actually dropping.

- The vine, gators, and trees in the "Get Across!" minigame now use a much
  darker shade of green, to make them more visible against the light blue
  background and the pond.

- The outline around the title in the main menu has been made thicker.

**Removed**

- Optimized binaries no longer include the Bullet physics engine, because this
  engine is only used for 3D scenes in Godot.


## Version 0.14-uncursed - 2024-04-09

**Added**

- A brand-new minigame: "Defend!" (legally distinct from Pong)

- The player can now enter debug mode for a specific minigame using the
  --debug-minigame command-line option.  This will also show the "Debug Menu"
  button on the main menu.

- A list of minigames is output to the command line, and the Debug Menu button
  is shown, if "--debug-minigame" is passed but no minigame ID is given.

**Fixed**

- A bug existed in the code which allowed the player to attempt to quit before
  the game has begun, causing the game to try to clear data that doesn't exist.
  This update should have fixed that.

- The spawn rules for the pizzas in the "Don't Get Pizza'd!" minigame have been
  overhauled so that the pizzas will consistently appear at a fair distance
  away from the player.

- The minigames are now loaded on-demand.  This has the effect of requiring
  less memory, but also means that there are no longer leaked resources on
  exit, because the engine now has an opportunity to free up resources
  in-between minigames.  
  This change has the unfortunate side-effect that the debug menu can no longer
  pull instructions from the minigames themselves to label the buttons, so
  instead names are taken from their scene paths.

**Changed**

- The cheat code to open the debug menu has been changed.

- The "Hit a Home Run!" minigame has been made more forgiving.  It is now
  substantially easier to hit a home run.

- The hit boxes in the "Don't Get Pizza'd!" minigame have been tweaked very
  slightly to align with their sprites.  This probably won't have a noticeable
  impact on gameplay.

- The pizzas in the "Don't Get Pizza'd!" minigame can now move farther off of
  the screen before wrapping around, making them easier to dodge.

- Some identical arrow sprites have been consolidated into a single sprite and
  now use color modulation to change colors to save space.
  The "next" and "previous" buttons in the Controls dialog in particular now
  use the same arrow sprite, just pointed in different directions.

- Several elements of the foreground image in the "Race that Rig!" minigame
  have been moved to the background to make for a less janky appearance without
  detracting from the intended jankiness of the minigame.

  - The background in the "Race that Rig!" minigame has been changed to no
    longer be a dark blue gradient.  Instead the minigame will randomly choose
    between a daytime or a nighttime sky.

- Every image in the game has been compressed to allow for smaller file sizes
  and faster loading times.

- The executable icon now uses the Janitor font, the same one used on the title
  screen.

- The "sky" texture used in several minigames has been replaced with a gradient
  which uses much more pleasant colors, which blend together much better
  without the nasty brown-ish color that the previous sky texture suffered
  from.  This also has the unintended but very pleasant side-effect of making
  some (but not all) of the cloud textures blend into the sky much better.

- The background in the "Hit a Home Run!" minigame has been changed so that
  the pitcher is standing on his pitcher's mound.  The ugly turd clouds have
  also been replaced with the fluffier cloud sprites used in other minigames.


## Version 0.13.5 - 2024-03-28

**Fixed**

- Pressing button 1 on a controller will no longer exit the game.  Instead,
  this function has been assigned to the Select button and the Escape key.
  Button 1 is still used to navigate backwards in menus and close dialogs.

- The missile in the "Shoot Five!" minigame is now only removed after the
  player's death if it has not yet been fired, removing a bug which could cause
  crashes.  If the missile has been fired by the time the player dies, it will
  now continue on its course until detonation, as normal.

**Added**

- The "Don't Get Pizza'd!" minigame now has a starry background!

- There is now a slide in the Controls menu explaining the controller
  mappings.


## Version 0.13.4 - 2024-03-23

**Changed**

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

**Fixed**

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


## Version 0.13.3 - 2024-03-17

**Changed**

- Updated to Godot Engine 3.5.3-stable.

**Corrections**

- In version 0.13.1, some source files were moved around in order to be more
  compliant with standard practice for Godot projects, but relevant licensing
  documentation was updated incompletely.  The documentation in the LICENSE
  file was corrected with this version.


## Version 0.13.2-hotfix - 2024-01-14 [YANKED]

**Fixed**

- Implemented a bugfix from an archived version of the repository.  This fix
  prevents the "Shoot Five!" minigame from causing crashes by attempting to
  do work with the player node after it has been removed due to the player's
  ship being destroyed.


## Version 0.13.1 - 2024-01-11 [YANKED]

**Changed**

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


## Version 0.13 - 2022-04-20

**Added**

- The version number label on the main menu will now display the version number
  for the version of the Godot Engine that was used to build Minigame Madness.

- New minigame: Dance, Dance, Dance!

- A SConstruct profile used to compile an optimal version of the Godot Engine
  for Minigame Madness exports is now available in custom.py.

**Changed**

- Minigames in the Debug menu are now listed by title rather than number.

**Deprecated**

- The version number "types," i.e. "Pre-Release," "Alpha," and "Beta" have been
  deprecated.  For the time being, Minigame Madness will now simply use its own
  version number without additional unnecessary fluff.


# Versioning System

When Minigame Madness started, the anticipation was that development would be
very rapid and would quickly lead in to other projects.  As such, some early
versions used the year, week, and day of release as the basis for the version
number.  However, this was determined to be confusing and unhelpful, and so
this versioning system was dropped.  These version numbers are no longer
considered to be a part of the version history of Minigame Madness.

Minigame Madness's current version numbering system is similar to
[semantic versioning][SemVer] in intent but differs in important details.
This is partly because Minigame Madness is a solo project and I am still in
the process of learning best practices, but it's also because I think semantic
versioning, as specified in the _de facto_ standard, leaves a little to be
desired from a game development perspective.

As it stands, here are what the version numbers mean for Minigame Madness.
The version numbers are split into four sections, but by default only two are
shown.  
For the purposes of illustration, two example versions will be used:
A: `0.14_2.3`, and B: `1.0`

- **Major**: The "Major" version number is as it is defined in the semantic
  versioning standard, and refers to the backwards compatibility of the
  current version of Minigame Madness.  For our purposes, "backwards
  compatible" is a somewhat arbitrary specification, because this project is
  not meant to interface with anything, but that may change in the future.  
  At time of writing, the Major version is 0, indicating that Minigame
  Madness's codebase is in a prerelease state and should not be considered
  stable.  
  In example A, the Major version is 0.  In example B, the Major version is 1.

- **Minor**: The "Minor" version number is incremented any time a new minigame
  is added to Minigame Madness.  After version 1.0 is released, however, the
  meaning of this number may change to simply indicate any newly-added
  features, as in the semantic versioning standard.  
  This number will revert to 0 any time the Major version is changed.  
  In example A, the Minor version is 14.  In example B, the Minor version is
  0.

- **Minor 2nd**: The "Minor 2nd" version number, for lack of a better name,
  functions as a "second" Minor version, and is appended to the Minor version
  following an `_` underscore.  This number is used to indicate when a
  minigame has been replaced or has changed form siginficantly, effectively
  meaning that a new minigame has been created without adding to the total
  number of minigames, hence why this is called a "second Major version."  
  This number will revert to 0 any time the Major or Minor version is changed.
  If the Minor 2nd version is 0, it is not displayed.  
  Following version 1.0, Minor 2nd versions will not be used.  
  In example A, the Minor 2nd version is 2.  Example B does not have a Minor
  2nd version, but if it did it would be 0.

- **Patch**:  The "Patch" version number is as defined in the semantic
  versioning standard, and indicates minor changes &ndash; usually bug fixes,
  tweaks to gameplay, or optimizations &ndash; which have been included in a
  release which _does not_ include substantive additions of new features.  
  This number will revert to 0 any time the Major, Minor, or Minor 2nd
  versions are changed.  
  If the Patch version is 0, it is not displayed.  
  In example A, the Patch version is 3.  In example B, the Patch version is 0,
  but it is not shown.

The reason why Minor 2nd and Patch versions are not shown if they are at 0 is
largely a historical contrivance, and is done to make the version number less
cumbersome and more aesthetically pleasing to the end-user.  In my experience,
most non-technical people like the "number-dot-number" rhythm of simpler
versioning schemes, and so patches are indicated only when they are relevant.

Suffixes used to indicate prereleases such as alphas and betas have largely
been abandoned due to the limited need for prerelease versions.  However,
builds which are not yet production-ready are still indicated by appending the
`-pre` tag to the version number; for example, prerelease versions of version
`0.15` would be indicated as `0.15-pre`.  In-game, this is displayed to the
user as `0.15 Prerelease`.  Minigame Madness's versioning system is still able
to accommodate numbered prerelease versions such as `0.15-pre.3` (`0.15
Prerelease 3`) or `1.0-alpha.1` (`1.0 Alpha 1`) if necessary, but there are no
plans to use this until development begins on version 1.0.

To see how the version number is encoded, please see the
[Version](master/singletons/version.gd) singleton.
