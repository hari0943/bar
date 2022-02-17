#!/bin/sh
dbus-launch --exit-with-session pipewire &
dbus-launch --exit-with-session pipewire-media-session &
dbus-launch --exit-with-session pipewire-pulse &
