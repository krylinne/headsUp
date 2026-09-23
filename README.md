# headsUp

A macOS menu bar app that shows your current or upcoming class from your calendar.

## Features

- Menu bar text showing "next class" or "ends in Nm" countdown
- Automatic updates every second
- Reads from EventKit — no separate config file for events
- Hourly refresh + manual refresh via menu

## Requirements

- macOS 14 (Sonoma) or later
- A calendar containing your class schedule

## Build & Run

    swift run // in the root directory

## How to kill it

    pkill headsUp // in the root directory

## Package as a .app

    ./build-app.sh
    open headsUp.app

## Configuration

Set `data.calendarName = "Calendar"` in `main.swift` to the name of the calendar
containing your class events. Leave it `nil` to query no calendars (defaults to
nothing to avoid flooding with birthdays and holidays).

## Structure

    code/
      main.swift        — entry point, timer wiring
      bar.swift         — menu bar status item, display state machine
      data.swift        — EventKit wrapper, event fetching
      eventStruct.swift — the simple event struct (name, start, end)
      update.swift      — picks the current event each tick
