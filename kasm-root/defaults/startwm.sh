#!/usr/bin/env bash
set -e

display="${DISPLAY:-:1}"
display_number="${display#:}"

for _ in $(seq 1 100); do
    if [ -S "/tmp/.X11-unix/X${display_number}" ]; then
        break
    fi
    sleep 0.1
done

# Enable Nvidia GPU support if detected.
if command -v nvidia-smi >/dev/null 2>&1; then
    export LIBGL_KOPPER_DRI2=1
    export MESA_LOADER_DRIVER_OVERRIDE=zink
    export GALLIUM_DRIVER=zink
fi

exec /usr/bin/openbox-session
