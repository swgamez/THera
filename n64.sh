 #!/bin/bash

if  [[ $1 == "standalone" ]]; then
/opt/mupen64plus/mupen64plus --resolution 320x240 --plugindir /opt/mupen64plus --gfx mupen64plus-video-rice.so --corelib /opt/mupen64plus/libmupen64plus.so.2 "$2"
else
/usr/local/bin/%EMULATOR% -L /home/odroid/.config/%EMULATOR%/cores/%CORE%_libretro.so "$2"
fi
