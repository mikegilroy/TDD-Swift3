//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 19/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class InputViewControllerTests: XCTestCase {
	
	var sut: InputViewController!
	var placemark: MockPlacemark!
	
    override func setUp() {
        super.setUp()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
		
		_ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
	
	func test_HasTitleTextField() {
		XCTAssertNotNil(sut.titleTextField)
	}
	
	func test_HasLocationTextField() {
		XCTAssertNotNil(sut.locationTextField)
	}
	
	func test_HasDateTextField() {
		XCTAssertNotNil(sut.dateTextField)
	}
	
	func test_HasDescriptionTextField() {
		XCTAssertNotNil(sut.descriptionTextField)
	}
	
	func test_HasDoneButton() {
		XCTAssertNotNil(sut.doneButton)
	}
	
	func test_HasCancelButton() {
		XCTAssertNotNil(sut.cancelButton)
	}
	
	func test_Save_UsesGeocoderToGetLocationFromAddress() {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"
		
		
		let timestamp = 1456095600.0
		let date = Date(timeIntervalSince1970: timestamp)
		
		
		sut.titleTextField.text = "Foo"
		sut.dateTextField.text = dateFormatter.string(from: date)
		sut.locationTextField.text = "Bar"
		sut.addressTextField.text = "Infinite Loop 1, Cupertino"
		sut.descriptionTextField.text = "Baz"
		
		
		let mockGeocoder = MockGeocoder()
		sut.geocoder = mockGeocoder
		
		sut.itemManager = ItemManager()
		
		
		sut.save()
		
		placemark = MockPlacemark()
		let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
		placemark.mockCoordinate = coordinate
		mockGeocoder.completionHandler?([placemark], nil)
		
		
		let item = sut.itemManager?.item(at: 0)
		
		
		let testItem = ToDoItem(title: "Foo",
		                        description: "Baz",
		                        timestamp: timestamp,
		                        location: Location(name: "Bar",
		                                           coordinate: coordinate))
		
		
		XCTAssertEqual(item?.location, testItem.location)
	}
	
	func test_Save_UsesTitleFromTitleTextField() {
		sut.titleTextField.text = "Foo"
		sut.itemManager = ItemManager()
		sut.save()
		
		let item = sut.itemManager?.item(at: 0)
		
		XCTAssertEqual(item?.title, "Foo")
	}
	
	func test_Save_UsesDescriptionFromTitleTextField() {
		sut.titleTextField.text = "Foo"
		sut.descriptionTextField.text = "Bar"
		sut.itemManager = ItemManager()
		sut.save()
		
		let item = sut.itemManager?.item(at: 0)
		
		XCTAssertEqual(item?.description, "Bar")
	}
	
	func test_SaveButtonHasSaveAction() {
		let doneButton: UIButton = sut.doneButton
		
		
		guard let actions = doneButton.actions(forTarget: sut,forControlEvent: .touchUpInside) else {
			XCTFail()
			return
		}
		
		
		XCTAssertTrue(actions.contains("save"))
	}
}


extension InputViewControllerTests {
	
	class MockGeocoder: CLGeocoder {
		var completionHandler: CLGeocodeCompletionHandler?
		
		override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
			self.completionHandler = completionHandler
		}
	}
	
	class MockPlacemark: CLPlacemark {
		var mockCoordinate: CLLocationCoordinate2D?
	
		override var location: CLLocation? {
			guard let mockCoordinate = mockCoordinate else {
				return CLLocation()
			}
			return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
		}
	}
}





