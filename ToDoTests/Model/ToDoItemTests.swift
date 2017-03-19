//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func test_Init_WhenGivenTitle_SetsTitle() {
		let item = ToDoItem(title: "Foo")
		XCTAssertEqual(item.title, "Foo", "Should set title")
	}
	
	func test_Init_WhenGivenDescription_SetsDescription() {
		let item = ToDoItem(title: "Foo", description: "This is a foo item")
		XCTAssertEqual(item.description, "This is a foo item", "Should set description")
	}
	
	func test_Init_WhenGivenTimestamp_SetsTimestamp() {
		let item = ToDoItem(title: "Foo", timestamp: 10.0)
		XCTAssertEqual(item.timestamp, 10.0, "Should set timestamp")
	}
	
	func test_Init_WhenGivenLocation_SetsLocation()  {
		let location = Location(name: "Foo")
		let item = ToDoItem(title: "Foo", location: location)
		XCTAssertEqual(location.name, item.location?.name, "Should set location")
	}
	
	func test_TitlesDiffer_AreNotEqual() {
		var item1 = ToDoItem(title: "Foo")
		var item2 = ToDoItem(title: "Bar")
		XCTAssertNotEqual(item1, item2)
		
		item1 = ToDoItem(title: "Bar")
		item2 = ToDoItem(title: "Foo")
		XCTAssertNotEqual(item1, item2)
	}
	
	func test_Items_WhenLocationDiffers_AreNotEqual() {
		let item1 = ToDoItem(title: "Foo", location: Location(name: "1"))
		let item2 = ToDoItem(title: "Foo", location: Location(name: "2"))
		
		XCTAssertNotEqual(item1, item2)
	}
	
	func test_Items_WhenOneLocationNilAndOtherIsNot_AreNotEqual() {
		var first = ToDoItem(title: "", location: nil)
		var second = ToDoItem(title: "", location: Location(name: "Foo"))
		XCTAssertNotEqual(first, second)
		
		first = ToDoItem(title: "", location: Location(name: "Foo"))
		second = ToDoItem(title: "", location: nil)
		XCTAssertNotEqual(first, second)
	}
	
	func test_Items_WhenTimestampDiffers_AreNotEqual() {
		var first = ToDoItem(title: "", timestamp: 0.0)
		var second = ToDoItem(title: "", timestamp: 1.0)
		XCTAssertNotEqual(first, second)
		
		first = ToDoItem(title: "", timestamp: 1.0)
		second = ToDoItem(title: "", timestamp: 0.0)
		XCTAssertNotEqual(first, second)
	}
	
	func test_Items_WhenDescriptionDiffers_AreNotEqual() {
		var first = ToDoItem(title: "", description: "Foo")
		var second = ToDoItem(title: "", description: "Bar")
		XCTAssertNotEqual(first, second)
		
		first = ToDoItem(title: "", description: "Bar")
		second = ToDoItem(title: "", description: "Foo")
		XCTAssertNotEqual(first, second)
	}
}
