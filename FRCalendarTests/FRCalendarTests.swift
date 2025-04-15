//
//  FRCalendarTests.swift
//  FRCalendarTests
//
//  Created by Enrique Haro Márquez on 2025-04-02.
//

import XCTest
import FRCalendar

final class FRCalendarTests: XCTestCase {
    let frDates = [
       FRDate(1, 1, 1),
       FRDate(1, 13, 5),
       FRDate(2, 1, 1),
       FRDate(3, 13, 5),
       FRDate(3, 13, 6),
       FRDate(4, 1, 1),
       FRDate(7, 13, 5),
       FRDate(7, 13, 6),
       FRDate(8, 1, 1),
       FRDate(11, 13, 5),
       FRDate(11, 13, 6),
       FRDate(12, 1, 1),
       FRDate(15, 13, 5),
       FRDate(15, 13, 6),
       FRDate(16, 1, 1),
       FRDate(20, 13, 5),
       FRDate(20, 13, 6),
       FRDate(21, 1, 1),
       FRDate(32, 13, 5),
       FRDate(32, 13, 6),
       FRDate(33, 1, 1),
       FRDate(44, 13, 5),
       FRDate(44, 13, 6),
       FRDate(45, 1, 1),
       FRDate(82, 13, 5),
       FRDate(82, 13, 6),
       FRDate(83, 1, 1),
       FRDate(98, 13, 5),
       FRDate(98, 13, 6),
       FRDate(99, 1, 1),

       FRDate(102, 13, 5),
       FRDate(102, 13, 6),
       FRDate(103, 1, 1),
       FRDate(131, 13, 5),
       FRDate(131, 13, 6),
       FRDate(132, 1, 1),
       FRDate(139, 13, 6),
       FRDate(233, 7, 13),
       FRDate(233, 7, 15)
    ]

    let gDates = [
        "1792-09-22",
        "1793-09-21",
        "1793-09-22",
        "1795-09-21",
        "1795-09-22",
        "1795-09-23",
        "1799-09-21",
        "1799-09-22",
        "1799-09-23",
        "1803-09-22",
        "1803-09-23",
        "1803-09-24",
        "1807-09-22",
        "1807-09-23",
        "1807-09-24",
        "1812-09-21",
        "1812-09-22",
        "1812-09-23",
        "1824-09-21",
        "1824-09-22",
        "1824-09-23",
        "1836-09-21",
        "1836-09-22",
        "1836-09-23",
        "1874-09-21",
        "1874-09-22",
        "1874-09-23",
        "1890-09-21",
        "1890-09-22",
        "1890-09-23",

        "1894-09-21",
        "1894-09-22",
        "1894-09-23",
        "1923-09-22", // BAD
        "1923-09-23",
        "1923-09-24",
        "1931-09-23",
        "2025-04-02",
        "2025-04-04"
    ]

    func testSuccessfulConverstionToGreg() {
        for i in 0..<frDates.count {
            let gDate = frDates[i].toGregorian().string
            XCTAssertEqual("\(gDate)", gDates[i])
        }
    }
    
    func testGivenGregorianDateWhenConvertedToFRCThenCorrect() {
        for i in 0..<frDates.count {
            let gDate = Date.from(string: gDates[i])!
            let frDate = gDate.toRepublican().string
            let result = frDate == frDates[i].string ? " " : "X"
            let suffix = String(frDates[i].string.suffix(1)) == "6" ? "Leap" : ""
            print("Date: \(gDate.string), \(frDate) \(result) \(frDates[i].string) \(suffix)")
            XCTAssertEqual("\(frDate)", frDates[i].string)
        }
    }
}

