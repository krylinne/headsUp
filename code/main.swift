import AppKit

let app = NSApplication.shared
app.setActivationPolicy(.accessory)

let bar = menuBar()
let data = calendarData()
data.calendarName = "Calendar"

data.requestAccess { granted in
    if granted {
        data.refresh()

        // Tick once per second — drives the menu bar updates
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            tick()
        }
    } else {
        bar.setText("no calendar access")
    }
}

app.run()