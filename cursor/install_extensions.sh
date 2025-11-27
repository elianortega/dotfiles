#!/bin/bash

echo "Installing Cursor extensions..."
xargs -L 1 cursor --install-extension < cursor-extensions.txt
