#!/bin/env bash

# Copyright (c) 2025 Daniel Fichtinger <daniel@ficd.sh>

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. Neither the name of the author nor the names of its contributors may
#    be used to endorse or promote products derived from this software

# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

# depends: wf-recorder, libnotify

TEMPDIR="/tmp/niri-recorder"
mkdir -p "$TEMPDIR"
LOCK="$TEMPDIR/lock"
RFMT=".mkv"
OFMT=".mp4"
RAW="$TEMPDIR/raw$RFMT"
OUTDIR="$HOME/Videos/niri-recorder"
mkdir -p "$OUTDIR"

socat=$(command -v socat &>/dev/null && echo true || echo false)

# sends current recording state to socket
function sig {
    [ "$socat" = true ] && echo "$1" | socat - UNIX-CONNECT:/tmp/recorder-sock.sock
}

# function generates unique name for recording
function compname {
    now=$(date +"%y-%m-%d-%H:%M:%S")
    echo "$OUTDIR/$now$OFMT"
}

# First we need to check if the recording
# lockfile exists.
if [[ -f "$LOCK" ]]; then
    # Stop the recording
    sig "STP"
    kill "$(cat "$LOCK")"
    # remove lockfile
    rm "$LOCK"
    outpath="$(compname)"
    sig "CMP"
    # compress the recording
    ffmpeg -y -i "$RAW" -c:v libx264 -preset slow -crf 21 -r 30 -b:v 2M -maxrate 3M -bufsize 4M -c:a aac -b:a 96k -movflags +faststart "$outpath" || (
        sig "ERR"
        exit 1
    )
    # copy URI path to clipboard
    wl-copy -t 'text/uri-list' <<<"file://$outpath" || (
        sig "ERR"
        exit 1
    )
    sig "CPD"
    # delete the raw recording
    rm "$RAW"

else
    # count how many monitors are attached
    num_mon=$(niri msg --json outputs | jq 'keys | length')
    wf_flags="-Dyf"
    if [ "$1" = "region" ]; then
        # select a screen region
        sel=$(slurp) || exit 1
        wf-recorder -g "$sel" "$wf_flags" "$RAW" &
    elif [ "$1" = "screen" ] || [ "$1" = "" ] && ((num_mon > 1)); then
        if [ "$2" = "focused" ] || [ "$2" = "current" ]; then
            # use jq to get the dimensions instead of slurp
            sel="$(niri msg --json focused-output |
                jq -r '.logical | "\(.x),\(.y) \(.width)x\(.height)"')"
        else
            # select entire screen
            sel=$(slurp -o) || exit 1
        fi
        wf-recorder -g "$sel" "$wf_flags" "$RAW" &
    else
        # this runs when screen is specified and there's only one monitor
        # it also runs with no args bc screen is default
        wf-recorder "$wf_flags" "$RAW" &
    fi

    sig "REC"
    # create lockfile
    touch "$LOCK"

    # save recorder's process id to lockfile
    PID=$!
    echo "$PID" >"$LOCK"
fi
