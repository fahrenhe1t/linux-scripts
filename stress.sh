#!/bin/bash
stress -c 2 -i 1 -m 1 --vm-bytes 128M -t 60s
