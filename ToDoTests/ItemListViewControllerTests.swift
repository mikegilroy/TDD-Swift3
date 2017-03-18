//
//  ItemListViewControllerTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
@testable import ToDo

class ItemListViewControllerTests: XCTestCase {
	
	var sut: ItemListViewController!
	
    override func setUp() {
        super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
		_ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func test_TableViewIsNotNilAfterLoad() {
		XCTAssertNotNil(sut.tableView)
	}
	
	func test_LoadingView_SetsTableViewDataSource() {
		XCTAssertTrue(sut.tableView?.dataSource is ItemListDataProvider)
	}
	
	func test_LoadingView_SetsTableViewDelegate() {
		XCTAssertTrue(sut.tableView?.delegate is ItemListDataProvider)
	}
	
	func test_LoadingView_SetsTableViewDataSourceAndDelegateToSameObject() {
		XCTAssertEqual(sut.tableView.dataSource as? ItemListDataProvider, sut.tableView.delegate as? ItemListDataProvider)
	}
}
