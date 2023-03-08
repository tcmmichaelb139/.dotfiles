#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title mdbg
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }

# Documentation:
# @raycast.description Downloads and moves Chinese strokes to Anki and copies text to clipbaord
# @raycast.author Michael Bao
# @raycast.authorURL https://github.com/tcmmichaelb139

./../mdbg $1
