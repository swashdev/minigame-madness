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

The game is currently in a prerelease state with 11 fully playable minigames.

Legal Stuff
-----------

Minigame Madness is **mostly** [public domain software].  I
emphasize "mostly" because the game contains exactly one non-public-domain
asset: [the song "Skippitybop" by Spadezer], which is released under the
[Creative Commons Attribution 3.0 Unported] license.

Additionally, even though Minigame Madness itself is in the public domain,
compiled binaries are subject to [the Godot Engine license], because the game
runs in the Godot engine.

In spite of this, all of the work done by me on Minigame Madness will remain
fully in the public domain.  Further information on other assets used in the
game can be found on the Credits screen in-game.

As of version 21.18.3-alpha, the game contains a comprehensive list of
third-party licenses to which the Godot Engine is subject as of version
3.3-stable, so license compliance shouldn't be a problem.

[public domain software]: LICENSE

[the song "Skippitybop" by Spadezer]: https://www.newgrounds.com/audio/listen/944805

[Creative Commons Attribution 3.0 Unported]: https://creativecommons.org/licenses/by/3.0/

[the Godot Engine license]: https://godotengine.org/license

Compiling
---------

To my knowledge, the Godot Engine currently allows exports of projects for
HTML5, Windows, Mac OSX, Linux, Android, and iOS.  Wikipedia and a distant
memory suggests that it also supports FreeBSD, NetBSD, and OpenBSD, but for
the life of me I can't find export templates for those.  Your mileage may
vary.  
Minigame Madness was originally designed for the web and desktops, but if you
want to try and get it working on a smart phone you be my guest.

Compiling a Godot Engine game is _super_ easy.  The first step is to clone a
copy of this repository into a directory on your computer.  The source code
and other assets in this repository don't require any additional setup; every
export I've ever done for this game has been a very simple
push-button-get-game affair.

The next step is to download a copy of the [Godot Engine].  You can acquire
Godot from their website or [on Steam] or grab the source code
[right here on GitHub].

[Godot Engine]: https://godotengine.org/

[on Steam]: https://store.steampowered.com/app/404790/Godot_Engine/

[right here on GitHub]: https://github.com/godotengine/godot

After you've acquired Godot, it's a simple matter of [importing the project]
by pointing the project manager to the project file in the directory you
copied this repository to and finally
[exporting a binary for your chosen system].  The Godot documentation has
*exceptionally* well-written tutorials that will show you how to do this.

[importing the project]: https://docs.godotengine.org/en/latest/tutorials/editor/project_manager.html#opening-and-importing-projects

[exporting a binary for your chosen system]: https://docs.godotengine.org/en/stable/getting_started/workflow/export/exporting_projects.html#export-menu

I Found a Bug!
--------------

Good for you!  Go ahead and let me know by [leaving an Issue] on Minigame
Madness's GitHub page.  Be sure to include details like the game's version
number (displayed in the lower-left when you start the game), what system
you're running it on, and which minigame you encountered the bug on.  Oh, and
describe the bug in detail, too.  That step is pretty important.

[leaving an Issue]: https://github.com/swashdev/minigame-madness/issues
