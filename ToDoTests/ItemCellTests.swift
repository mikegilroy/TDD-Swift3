//
//  ItemCellTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 19/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
import UIKit
@testable import ToDo

class ItemCellTests: XCTestCase {
	
	var tableView: UITableView!
	let dataSource = FakeDataSource()
	var cell: ItemCell!
	
	override func setUp() {
		super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
		_ = controller.view
		
		tableView = controller.tableView
		tableView.dataSource = dataSource
		
		cell = tableView?.dequeueReusableCell(withIdentifier: "ItemCell", for: IndexPath(row: 0, section: 0)) as! ItemCell
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func test_HasNameLabel() {
		XCTAssertNotNil(cell.titleLabel)
	}
	
	func test_HasLocationLabel() {
		XCTAssertNotNil(cell.locationLabel)
	}
	
	func test_HasDateLabel() {
		XCTAssertNotNil(cell.dateLabel)
	}
	
	func test_ConfigCell_SetsLabels() {
		let location = Location(name: "Bar")
		let item = ToDoItem(title: "Foo", description: nil, timestamp: 1456150025, location: location)
		
		cell.configCell(with: item)
		
		XCTAssertEqual(cell.titleLabel.text, "Foo")
		XCTAssertEqual(cell.dateLabel.text, "02/23/2016")
		XCTAssertEqual(cell.locationLabel.text, "Bar")
	}
	
	func test_ConfigCell_WhenItemIsChecked_IsStrokeThrough() {
		let location = Location(name: "Bar")
		let item = ToDoItem(title: "Foo", description: nil, timestamp: 1456150025, location: location)
		
		cell.configCell(with: item, isChecked: true)
		
		let attributedString = NSAttributedString(string: "Foo",
		                                          attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
		
		XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
		XCTAssertNil(cell.dateLabel.text)
		XCTAssertNil(cell.locationLabel.text)
	}
	
}


extension ItemCellTests {
	
	class FakeDataSource: NSObject, UITableViewDataSource {
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return 1
		}
		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			return UITableViewCell()
		}
		
	}
}
