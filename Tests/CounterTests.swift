//
//  CounterTests.swift
//  Tests
//
//  Created by Thiago Campos on 17/10/26.
//

@testable import Conte
import SwiftData
import Testing

struct CounterTests {
    @Test("Counter only requires a title")
    func createCounterWithMinimumInput() {
        let counter = Counter(title: "Cups of Coffee")
        #expect(counter.title == "Cups of Coffee")
    }

    @Test("Counter can start with count")
    func createCounterWithInitialCount() {
        let counter = Counter(title: "Missed classes", count: 5)
        #expect(counter.count == 5)
    }

    @Test("Counter's creation date is registered on init")
    func counterHasCreationDate() {
        let now = Date.now
        let counter = Counter(title: "Cups of Coffee", creationDate: now)
        #expect(counter.creationDate == now)
    }

    @Test("Counter's modification date is the same as the creation date")
    func modificationDateMatchesCreationDate() {
        let now = Date.now
        let counter = Counter(title: "Cups of Coffee", creationDate: now)
        #expect(counter.modificationDate == now)
        #expect(counter.creationDate == counter.modificationDate)
    }
}
