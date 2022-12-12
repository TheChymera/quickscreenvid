#!/usr/bin/env bash

killall wf-recorder --signal SIGINT
pactl unload-module module-null-sink
pactl unload-module module-loopback
