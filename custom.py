# This file is used when compiling the Godot Engine to produce a build optimal
# for Minigame Madness.  It will remove modules which are not necessary so that
# exported binaries will not be bloated by stuff we don't need.  These build
# parameters have been tested on HTML5 and Linux.
#
# This file can be used for your build by running:
# scons profile=path/to/custom.py

extra_suffix = "minigame_madness"
deprecated = "no"
disable_advanced_gui = "no"
module_gdnative_enabled = "no"

# Builds which include an editor will require certain modules which are
# otherwise unnecessary.
if tools == "no":
    disable_3d = "yes"

    # Important note: Disabling the regex module will make the rich text box
    # node not work, even though it's been included in the build.
    module_regex_enabled = "no"

    # networking
    module_enet_enabled = "no"
    module_mbedtls_enabled = "no"
    module_upnp_enabled = "no"

    if target == "release":
        optimize = "size"

# fonts
module_freetype_enabled = "yes"

# compression
minizip = "no"

# image formats
module_bmp_enabled = "no"
module_jpg_enabled = "no"
module_tga_enabled = "no"
module_webp_enabled = "yes"
module_etc_enabled = "no"
module_hdr_enabled = "no"
module_opensimplex_enabled = "no"
module_tinyexr_enabled = "no"

# video & sound
module_minimp3_enabled = "no"

## ogg video & sound
module_ogg_enabled = "yes"
module_opus_enabled = "no"
module_stb_vorbis_enabled = "yes"
module_theora_enabled = "no"
module_vorbis_enabled = "no"
module_webm_enabled = "no"

# physics
module_bullet_enabled = "no"

# other
module_csg_enabled = "no"
module_dds_enabled = "no"
module_gdnavigation_enabled = "no"
module_gridmap_enabled = "no"
module_jsonrpc_enabled = "no"

# Additional scripting languages
module_visual_script_enabled = "no"

# VR
module_mobile_vr_enabled = "no"
module_arkit_enabled = "no"
module_camera_enabled = "no"
