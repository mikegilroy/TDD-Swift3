//
//  DetailViewControllerTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 19/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class DetailViewControllerTests: XCTestCase {
	
	var sut: DetailViewController!
	
    override func setUp() {
        super.setUp()
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
		_ = sut.view
    }
    
    override func tearDown() {
		super.tearDown()
    }

	func test_HasTitleLabel() {
		XCTAssertNotNil(sut.titleLabel)
	}
	
	func test_HasLocationLabel() {
		XCTAssertNotNil(sut.locationLabel)
	}
	
	func test_HasDateLabel() {
		XCTAssertNotNil(sut.dateLabel)
	}
	
	func test_HasDescriptionLabel() {
		XCTAssertNotNil(sut.descriptionLabel)
	}
	
	func test_HasCheckButton() {
		XCTAssertNotNil(sut.checkButton)
	}
	
	func test_HasMapView() {
		XCTAssertNotNil(sut.mapView)
	}
	
	func test_SettingItemInfo_SetsTextsToLabels() {
		let coordinate = CLLocationCoordinate2DMake(51.2277, 6.7735)
		
		let location = Location(name: "Bar", coordinate: coordinate)
		let item = ToDoItem(title: "Foo", description: "Baz", timestamp: 1456150025, location: location)
		
		let itemManager = ItemManager()
		itemManager.add(item)
		sut.itemInfo = (itemManager, 0)
		
		sut.beginAppearanceTransition(true, animated: true)
		sut.endAppearanceTransition()
		
		XCTAssertEqual(sut.titleLabel.text, "Foo")
		XCTAssertEqual(sut.dateLabel.text, "02/23/2016")
		XCTAssertEqual(sut.locationLabel.text, "Bar")
		XCTAssertEqual(sut.descriptionLabel.text, "Baz")
	
		XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
		XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.longitude, coordinate.longitude, accuracy: 0.001)
	}
	
	func test_CheckItem_ChecksItemInItemManager() {
		let item = ToDoItem(title: "Foo")
		let itemManager = ItemManager()
		itemManager.add(item)
		
		sut.itemInfo = (itemManager, 0)
		sut.checkItem()
		
		XCTAssertEqual(itemManager.toDoCount, 0)
		XCTAssertEqual(itemManager.doneCount, 1)
	}
	
	func test_CheckButtonTapped_CallsCheckItem() {
		let item = ToDoItem(title: "Foo")
		let itemManager = ItemManager()
		itemManager.add(item)
		
		let mock = MockDetailViewController()
		mock.itemInfo = (itemManager, 0)
		
		XCTAssertTrue(mock.itemChecked == false)
		
		mock.checkButtonTapped(self)
		
		XCTAssertTrue(mock.itemChecked)
	}
    
}

extension DetailViewControllerTests {
	
	class MockDetailViewController: DetailViewController {
		
		var itemChecked = false
		
		override func checkItem() {
			itemChecked = true
		}
	}
	
}

