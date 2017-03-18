//
//  ItemListDataProviderTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListDataProviderTests: XCTestCase {
	
	var sut: ItemListDataProvider!
	var tableview: UITableView!
	var controller: ItemListViewController!
	
    override func setUp() {
        super.setUp()
		
		sut = ItemListDataProvider()
		sut.itemManager = ItemManager()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		controller = storyboard.instantiateViewController(
				withIdentifier: "ItemListViewController") as! ItemListViewController
		
		
		_ = controller.view
		
		tableview = controller.tableView
		tableview.dataSource = sut
		tableview.delegate = sut
    }
    
    override func tearDown() {
        super.tearDown()
    }

	
	func test_NumberOfSections_IsTwo() {
		XCTAssertEqual(tableview.numberOfSections, 2)
	}
	
	func test_NumberOfRows_InFirstSection_IsToDoCount() {
		sut.itemManager?.add(ToDoItem(title: "Foo"))
		XCTAssertEqual(tableview.numberOfRows(inSection: 0), 1)
		sut.itemManager?.add(ToDoItem(title: "Bar"))
		tableview.reloadData()
		XCTAssertEqual(tableview.numberOfRows(inSection: 0), 2)
	}
	
	func test_NumberOfRows_InSecondSection_IsDonecount() {
		sut.itemManager?.add(ToDoItem(title: "Foo"))
		sut.itemManager?.add(ToDoItem(title: "Bar"))
		sut.itemManager?.checkItem(at: 0)
		
		XCTAssertEqual(tableview.numberOfRows(inSection: 1), 1)
		
		sut.itemManager?.checkItem(at: 0)
		tableview.reloadData()
		XCTAssertEqual(tableview.numberOfRows(inSection: 1), 2)
	}
	
	func test_CellForRow_ReturnsItemCell() {
		sut.itemManager?.add(ToDoItem(title: "Foo"))
		tableview.reloadData()
		
		let cell = tableview.cellForRow(at: IndexPath(row: 0, section: 0))
		XCTAssertTrue(cell is ItemCell)
	}
	
	func test_CellForRow_DequesCellFromTableView() {
		let mockTableView = MockTableView.mockTableView(withDataSource: sut)
		
		sut.itemManager?.add(ToDoItem(title: "Foo"))
		mockTableView.reloadData()
		
		_ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
		
		XCTAssertTrue(mockTableView.cellGotDequed)
	}
	
	func test_CellForRow_InSectionOne_CallsConfigCell() {
		let mockTableView = MockTableView.mockTableView(withDataSource: sut)
		
		let item = ToDoItem(title: "Bar")
		sut.itemManager?.add(item)
		mockTableView.reloadData()
		
		let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockItemCell
		
		XCTAssertEqual(cell.cachedItem, item)
	}
	
	func test_CellForRow_InSectionTwo_CallsConfigCell() {
		let mockTableView = MockTableView.mockTableView(withDataSource: sut)
		
		let item1 = ToDoItem(title: "Bar")
		let item2 = ToDoItem(title: "FooBar")
		sut.itemManager?.add(item1)
		sut.itemManager?.add(item2)
		sut.itemManager?.checkItem(at: 1)
		mockTableView.reloadData()
		
		let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockItemCell
		
		XCTAssertEqual(cell.cachedItem, item2)
	}
	
	func test_DeleteButton_InSectionOne_ShowsTitleCheck() {
		let deletButtonTitle = tableview.delegate?.tableView?(tableview, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
		
		XCTAssertEqual(deletButtonTitle, "Check")
	}
	
	func test_DeleteButton_InSectionTwo_ShowsTitleUncheck() {
		let deletButtonTitle = tableview.delegate?.tableView?(tableview, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
		
		XCTAssertEqual(deletButtonTitle, "Uncheck")
	}
	
	func test_CheckingAnItem_ChecksItInTheItemManager() {
		sut.itemManager?.add(ToDoItem(title: "Foo"))
		
		tableview.dataSource?.tableView?(tableview, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
		
		XCTAssertEqual(sut.itemManager?.toDoCount, 0)
		XCTAssertEqual(sut.itemManager?.doneCount, 1)
		XCTAssertEqual(tableview.numberOfRows(inSection: 0), 0)
		XCTAssertEqual(tableview.numberOfRows(inSection: 1), 1)
	}
	
	func test_UncheckingAnItem_UnchecksItInTheItemManager() {
		sut.itemManager?.add(ToDoItem(title: "Foo"))
		sut.itemManager?.add(ToDoItem(title: "Bar"))
		sut.itemManager?.checkItem(at: 0)
		sut.itemManager?.checkItem(at: 0)
		
		tableview.dataSource?.tableView?(tableview, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
		
		XCTAssertEqual(sut.itemManager?.toDoCount, 1)
		XCTAssertEqual(sut.itemManager?.doneCount, 1)
		XCTAssertEqual(tableview.numberOfRows(inSection: 0), 1)
		XCTAssertEqual(tableview.numberOfRows(inSection: 1), 1)
	}
	
}


extension ItemListDataProviderTests {
	
	class MockTableView: UITableView {
		var cellGotDequed = false
		
		override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
			cellGotDequed = true
			return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		}
		
		class func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
			
			let mockTableView = MockTableView(frame: CGRect(x:0, y: 0, width: 320, height: 480), style: .plain)
			mockTableView.dataSource = dataSource
			mockTableView.register(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
			return mockTableView
		}
	}
}

extension ItemListDataProviderTests {
	
	class MockItemCell: ItemCell {
		
		var cachedItem: ToDoItem?
		
		override func configCell(with item: ToDoItem) {
			cachedItem = item
		}
	}
}




