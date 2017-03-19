//
//  ItemManagerTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemManagerTests: XCTestCase {
	
	var sut: ItemManager!
	
	override func setUp() {
		sut = ItemManager()
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func test_ToDoCount_Initially_IsZero() {
		XCTAssertEqual(sut.toDoCount, 0)
	}
	
	func test_DoneCount_Initially_IsZero() {
		XCTAssertEqual(sut.doneCount, 0)
	}
	
	func test_AddItem_IncreaseToDoCountToOne() {
		sut.add(ToDoItem(title: "Foo"))
		XCTAssertEqual(sut.toDoCount, 1)
	}
	
	func test_ItemAt_AfterAddingAnItem_ReturnsThatItem() {
		let item = ToDoItem(title: "Foo")
		sut.add(item)
		let returnedItem = sut.item(at: 0)
		XCTAssertEqual(returnedItem.title, item.title)
	}
	
	func test_CheckItemAt_ChangesCount() {
		sut.add(ToDoItem(title: ""))
		sut.checkItem(at: 0)
		XCTAssertEqual(sut.toDoCount, 0)
		XCTAssertEqual(sut.doneCount, 1)
	}
	
	func test_CheckItemAt_RemovesItemFromToDoItems() {
		let first = ToDoItem(title: "First")
		let second = ToDoItem(title: "Second")
		
		sut.add(first)
		sut.add(second)
		
		sut.checkItem(at: 0)
		
		XCTAssertEqual(sut.item(at: 0).title, "Second")
	}
	
	func test_DoneItemAt_ReturnsCheckedItem() {
		let item = ToDoItem(title: "Foo")
		sut.add(item)
		
		sut.checkItem(at: 0)
		let returnedItem = sut.doneItem(at: 0)
		XCTAssertEqual(item.title, returnedItem.title)
	}
	
	func test_RemoveAll_ResultsInAllCountsZero() {
		sut.add(ToDoItem(title: "Foo"))
		sut.add(ToDoItem(title: "Bar"))
		sut.checkItem(at: 0)
		
		XCTAssertEqual(sut.toDoCount, 1)
		XCTAssertEqual(sut.doneCount, 1)
		
		sut.removeAll()
		XCTAssertEqual(sut.toDoCount, 0)
		XCTAssertEqual(sut.doneCount, 0)
	}
	
	func test_Add_WhenItemAlreadyAdded_DoesNotIncreaseCount() {
		let item = ToDoItem(title: "Foo")
		sut.add(item)
		
		XCTAssertEqual(sut.toDoCount, 1)
		
		sut.add(item)
		XCTAssertEqual(sut.toDoCount, 1)
	}
	
}
