Minigame Madness
================

Minigame Madness is a microgame project I started in November of 2020 to help
teach myself the Godot engine and some basic principles of design.  The
original goal was to have twenty minigames finished by the end of 2020, but
due to certain inevitable delays that got pushed back.

Minigame Madness is designed for web platforms but can also be exported for
desktop environments including Windows, MacOS, Linux, and maybe more!  See the
[Compiling] section for more details.

[Compiling]: #compiling

The game is currently in a prerelease state with 15 fully playable minigames.

Legal Stuff
-----------

Minigame Madness is **mostly** [public domain software][license].  I
emphasize "mostly" because the game contains exactly one non-public-domain
asset: [the song "Skippitybop" by Spadezer][skippitybop], which is released
under the [Creative Commons Attribution 3.0 Unported][cc-by] license.

Additionally, even though Minigame Madness itself is in the public domain,
compiled binaries are subject to [the Godot Engine license][godot-license],
and to [other open-source licenses used by Godot][4th-party],
because the game runs in the Godot engine.

In spite of this, all of the work done by me on Minigame Madness will remain
fully in the public domain.  Further information on other assets used in the
game can be found on the Credits screen in-game.

As of version 0.12.2-alpha, the game will display a comprehensive list of
third-party licenses to which any particular copy of Minigame Madness is
subject in the "Legal Stuff" menu in-game.

[license]: LICENSE.txt
[skippitybop]: https://www.newgrounds.com/audio/listen/944805
[cc-by]: https://creativecommons.org/licenses/by/3.0/
[godot-license]: https://godotengine.org/license
[4th-party]: https://github.com/godotengine/godot/blob/3.5/COPYRIGHT.txt

Debugging
---------

Trying to narrow down a bug?  You can access a debug menu by entering the
Konami Code on the main menu: Up, Up, Down, Down, Left, Right, Left, Right, B,
A.

Alternatively, you can start the game in debug mode for a specific minigame
using the following command-line option:

```dosbatch
--debug-minigame <id_num>
```

Replace `<id_num>` with a numeric identifier indicating which minigame you want
to test.  If you don't enter an ID number, the game will print out a list for
you.

I Found a Bug!
--------------

Good for you!  Go ahead and let me know by [leaving an Issue][Issues] on
Minigame Madness's GitHub page.  Be sure to include details like the game's
version number (displayed in the lower-left when you start the game), what
system you're running it on, and which minigame you encountered the bug on.
Oh, and describe the bug in detail, too.  That step is pretty important.

[Issue]: https://github.com/swashdev/minigame-madness/issues

Compiling
---------

To my knowledge, the Godot Engine currently allows exports of projects for
HTML5, Windows, Mac OSX, Linux, Android, and iOS.  Godot can also be compiled
for the BSDs if you wish, but this is not technically supported.
Minigame Madness was originally designed for the web and desktops, but if you
want to try and get it working on a smart phone you be my guest.

The next step is to download a copy of the [Godot Engine][godot].  You can
acquire Godot from their website or grab the source code
[right here on GitHub][godot-github].  Just make sure that you're downloading
Godot 3 &ndash; at least 3.5-stable &ndash; rather than Godot 4, as Minigame
Madness was made on Godot 3.5.  The version you're looking for might be
referred to on the website as an LTS version.

If you choose to [compile your own version of the Godot Engine][compile-godot],
you might consider using the profile included in [custom.py][custom.py] to
remove any modules that aren't needed to export a Minigame Madness binary.

[godot]: https://godotengine.org/
[godot-github]: https://github.com/godotengine/godot/tree/3.5
[compile-godot]: https://docs.godotengine.org/en/3.5/development/compiling/index.html
[custom.py]: ./custom.py

After you've acquired Godot, it's a simple matter of
[importing the project][importing] by pointing the project manager to the
project file in the directory you copied this repository to and finally
[exporting a binary for your chosen system][exporting].  The Godot
documentation has *exceptionally* well-written tutorials that will show you
how to do this.

[importing]: https://docs.godotengine.org/en/3.5/tutorials/editor/project_manager.html#opening-and-importing-projects

[exporting]: https://docs.godotengine.org/en/3.5/getting_started/workflow/export/exporting_projects.html#export-menu

**NOTE:** While exporting a copy of Minigame Madness, you should go into the
Resources tab on the export screen and find the text box labelled "Filters to
export non-resource files/folders" and type "COPYRIGHT.txt" (without the
quotes) into this box.  This will export Minigame Madness's licensing
information into the binary file you end up with, so that the game will be
able to display the licenses for Minigame Madness's various components.
