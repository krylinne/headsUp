import AppKit

final class menuBar {
    private let statusItem: NSStatusItem

    // Event mode state
    private var eventName: String?
    private var eventStart: Date?
    private var eventEnd: Date?
    private var eventHasNext: Bool = false

    func setText(_ text: String) {
        statusItem.button?.title = text
    }

    init() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        setText("headsUp is loading...")
    }

    // MARK: - Text mode (legacy + manual control)

    func fire(_ event: Bool) {
        if event {
            setText("event")
        } else {
            setText("none yet")
        }
    }

    // MARK: - Event mode

    func setEvent(name: String?, start: Date?, end: Date?, next: Bool) {
        self.eventName = name
        self.eventStart = start
        self.eventEnd = end
        self.eventHasNext = next

        setText(computeText())
    }

    private func computeText() -> String {
        guard let n = eventName, let s = eventStart, let e = eventEnd else {
            return "nothing for now"
        }

        let now = Date()

        if (now < s) {
            let remaining = s.timeIntervalSince(now)
            return "\(n) — in \(formatDuration(remaining))"
        }

        if (now < e) {
            let remaining = e.timeIntervalSince(now)
            return "\(n) — ends in \(formatDuration(remaining))"
        }

        if (eventHasNext) { return "get ready" }
        return "nothing for now"
    }

    // Converts a seconds count into "Xd Yh", "Xh Ym", or "Xm"
    private func formatDuration(_ seconds: Double) -> String {
        let total = Int(seconds)
        let days = total / 86400
        let hours = (total % 86400) / 3600
        let minutes = (total % 3600) / 60

        if (days > 0) {
            return "\(days)d \(hours)h \(minutes)m"
        }
        if (hours > 0) {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }
}