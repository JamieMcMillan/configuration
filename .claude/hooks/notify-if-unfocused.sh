#!/bin/bash
# Only send notification if user is not focused on the Claude Code tab in Warp
# ✳ prefix indicates a Claude Code session

read -r app_name window_title < <(osascript -e '
tell application "System Events"
    set frontProc to first application process whose frontmost is true
    set appName to displayed name of frontProc
    set windowTitle to ""
    try
        set windowTitle to name of first window of frontProc
    end try
    return appName & "|" & windowTitle
end tell' | tr '|' '\n' | head -2 | tr '\n' ' ')

# Only suppress if in Warp AND window title starts with ✳ (Claude Code indicator)
if [[ "$app_name" == "Warp" && "$window_title" == ✳* ]]; then
    exit 0
fi

osascript -e 'display notification "Response complete" with title "Claude Code" sound name "Glass"'
