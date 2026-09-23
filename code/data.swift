import EventKit

final class calendarData {
    private let store = EKEventStore()
    private(set) var events: [event] = []
    private(set) var authorized = false
    var calendarName: String? = nil

    func requestAccess(completion: @escaping (Bool) -> Void) {

        store.requestFullAccessToEvents { granted, error in
            self.authorized = granted
            if error != nil { 
                print("calendar access error: \(error!)") 
            }
            DispatchQueue.main.async { completion(granted) }
        }
    }

    func refresh() {
        // Step 1: bail out if no permission
        if (!authorized) {
            events = []
            print("Not Authorized")
            return
        }

        // Step 2: time window
        let now = Date()
        let weekLater = Calendar.current.date(byAdding: .day, value: 7, to: now)!

        // Step 3: decide which calendars to query
        var calendars: [EKCalendar] = []
        if (calendarName != nil) {
            let all = store.calendars(for: .event)
            for cal in all {
                if (cal.title == calendarName) {
                    calendars.append(cal)
                }
            }
            if(calendars.isEmpty){
                print("no match found")
            }
        }
        else{
            print("calendarName is empty")
        }

        // Step 4: build the query
        let eventFilter = store.predicateForEvents(
            withStart: now,
            end: weekLater,
            calendars: calendars
        )

        // Step 5: run the query
        let matchingList = store.events(matching: eventFilter)

        // Step 6: sort chronologically
        let sortedEvents = matchingList.sorted { a, b in
            return a.startDate < b.startDate
        }

        // Step 7: convert EKEvent to our event struct
        var converted: [event] = []
        for currentProcessing in sortedEvents {
            let title = currentProcessing.title ?? "(untitled)"
            let processed = event(name: title, start: currentProcessing.startDate, end: currentProcessing.endDate)
            converted.append(processed)
        }

        // Step 8: store
        events = converted
    }
}