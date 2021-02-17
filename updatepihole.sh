#!/bin/bash
# upgrades Pi-Hole to latest version
(( `id -u` )) && echo "This script MUST be run with root privileges, try prefixing with sudo. i.e. sudo $0" && exit 1
pihole -up

