import Foundation

func tick() {
    // no data.refresh() here anymore
    let now = Date()
    var current: event? = nil
    var currentIndex = -1

    for i in data.events.enumerated() {
        if (now < i.element.end) {
            current = i.element
            currentIndex = i.offset
            break
        }
    }

    var hasNext = false
    if (currentIndex >= 0 && currentIndex + 1 < data.events.count) {
        hasNext = true
    }

    if let c = current {
        bar.setEvent(name: c.name, start: c.start, end: c.end, next: hasNext)
    } else {
        bar.setEvent(name: nil, start: nil, end: nil, next: false)
    }
}