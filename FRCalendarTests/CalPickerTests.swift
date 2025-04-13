//
//  CalPickerTests.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-13.
//

import XCTest
import FRCalendar
import SwiftUI

final class CalPickerTests: XCTestCase {
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
	
//	func testGivenChosenDateWhenPickerComponentChangesThenAllComponentsAreCorrect() {
//		var type: Binding<CalPicker.CalType>
//		type = .constant(.republican)
//		var result: Binding<String>
//		result = .constant("")
//		let calPicker = CalPicker(type: type, result: result)
//		
//		let exp = XCTestExpectation(description: #function)
//		Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
//				exp.fulfill()
//		}
//		wait(for: [exp], timeout: 5.0)
//		
//		// Leap year
//		calPicker.year = 3
//		calPicker.month = 13
//		calPicker.day = 6
//		
//		// XCTAssertEqual(calPicker.day, 6)
//
//		// Non-leap year
//		calPicker.year = 233
//		calPicker.updateRangesAndDateComponents()
//		
//		XCTAssertEqual(calPicker.day, 5)
//	}
}
