#!/bin/env python
 
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

import os
import socket
import json
import asyncio

# helper prints dict as json string
def p(obj):
    print(json.dumps(obj), flush=True)
    
SOCKET = "/tmp/recorder-sock.sock"
# default tooltip
DEF_TT = "Click to record screen. Right-click to record region."
# default text
DEF_TEXT = "rec"

# Remove socket already exists
try:
    os.unlink(SOCKET)
except OSError:
    # doesn't exist, we're good
    pass

# track singleton delayed task
delayed_task = None

# async function to send a message with delay
async def delayed_msg(delay, message):
    try:
        await asyncio.sleep(delay)
        p(message)
    except asyncio.CancelledError:
        pass

# function handles message from socket 
def handle_message(data: str, loop):
    global delayed_task
    # always cancel delayed task
    # if there's new message
    if delayed_task:
        delayed_task.cancel()
    out = {}
    out_s = ""
    out_t = ""
    # process the message type
    if data:
        if data == "REC":
            out_s = "on"
            out_t = "Recording in progress. Click to stop."
        elif data == "CMP":
            out_s = "compressing"
            out_t = "Recording is being compressed."
        elif data == "CPD":
            out_s = "copied"
            out_t = "Recording has been copied to clipboard."
        elif data == "STP":
            out_s = "done"
            out_t = "Recording has been stopped."
        elif data == "ERR":
            out_s = "error"
            out_t = "Recording has encountered an error."
    # format the output
    out["text"] = f"rec: {out_s}" if out_s != "" else DEF_TEXT
    out["tooltip"] = out_t if out_t != "" else DEF_TT
    # print to waybar
    p(out)

    # check if delayed message should be sent afterwards
    if data in ["ERR", "CPD", "STP"]:
        # probably redundant but... for good measure lol
        if delayed_task:
            delayed_task.cancel()
        # delayed print of default output
        delayed_out = {"text": DEF_TEXT, "tooltip": DEF_TT}
        delayed_task = loop.create_task(delayed_msg(5, delayed_out))

# start the server
async def server():
    # pointer to this event loop
    loop = asyncio.get_running_loop()
    # open our socket
    with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as server:
        server.bind(SOCKET)
        # needed for async
        server.setblocking(False)
        # only one connection at a time
        server.listen(1)
        # main loop; runs until waybar exits
        while True:
            # receive data from socket
            conn, _ = await loop.sock_accept(server)
            with conn:
                # parse string
                data = (await loop.sock_recv(conn, 1024)).decode().strip()
                # handle the data
                handle_message(data, loop)

# main function
async def main():
    # start by outputing default contents
    p({"text": DEF_TEXT, "tooltip": DEF_TT})
    # start the server
    await server()

# entry point
asyncio.run(main())
