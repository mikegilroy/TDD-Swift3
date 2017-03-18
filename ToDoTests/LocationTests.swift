//
//  LocationTests.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDo

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

	func test_Init_GivenName_SetsName() {
		let location = Location(name: "Foo")
		XCTAssertEqual(location.name, "Foo", "Should set name")
	}
	
	func test_Init_GivenCoordinate_SetsCoordinate() {
		let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
		let location = Location(name: "Foo", coordinate: coordinate)
		XCTAssertEqual(coordinate.latitude, location.coordinate?.latitude, "Should set coordinate latitude")
		XCTAssertEqual(coordinate.longitude, location.coordinate?.longitude, "Should set coordinate longitude")
	}
	
	func test_EqualLocations_AreEqual() {
		let location1 = Location(name: "Foo")
		let location2 = Location(name: "Foo")
		
		XCTAssertEqual(location1, location2)
	}
	
	func test_Locations_WhenLatitudeDiffers_AreNotEqual() {
		performNotEqualTestWith(firstName: "Foo",
		                        secondName: "Foo",
		                        firstLatLong: (1,1),
		                        secondLatLong: (2,1))
	}
	
	func test_Locations_WhenLongitudeDiffers_AreNotEqual() {
		performNotEqualTestWith(firstName: "Foo",
		                        secondName: "Foo",
		                        firstLatLong: (1,1),
		                        secondLatLong: (1,2))
	}
	
	func test_Locations_WhenOnlyOneHasCoordinate_AreNotEqual() {
		performNotEqualTestWith(firstName: "Foo", secondName: "Foo", firstLatLong: (1,1), secondLatLong: nil)
	}
	
	func test_Locations_WhenNamesDiffer_AreNotEqual() {
		performNotEqualTestWith(firstName: "Foo", secondName: "Bar", firstLatLong: (1,1), secondLatLong: (1,1))
	}
	
	func performNotEqualTestWith(firstName: String,
	                             secondName: String,
	                             firstLatLong: (Double, Double)?,
	                             secondLatLong: (Double, Double)?,
	                             line: UInt = #line) {
		
		var firstCoordinate: CLLocationCoordinate2D? = nil
		if let firstLatLong = firstLatLong {
			firstCoordinate = CLLocationCoordinate2D(latitude: firstLatLong.0, longitude: firstLatLong.1)
		}
		let firstLocation = Location(name: firstName, coordinate: firstCoordinate)
		
		var secondCoordinate: CLLocationCoordinate2D? = nil
		if let secondLatLong = secondLatLong {
			secondCoordinate = CLLocationCoordinate2D(latitude: secondLatLong.0, longitude: secondLatLong.1)
		}
		let secondLocation = Location(name: secondName, coordinate: secondCoordinate)
		
		XCTAssertNotEqual(firstLocation, secondLocation)
	}
	
	func test_Locations_WhenLatitudeEqual_AreEqual() {
		performEqualTestWith(firstName: "Foo",
		                        secondName: "Foo",
		                        firstLatLong: (1,1),
		                        secondLatLong: (1,1))
	}
	
	func test_Locations_WhenLongitudeEqual_AreEqual() {
		performEqualTestWith(firstName: "Foo",
		                        secondName: "Foo",
		                        firstLatLong: (1,1),
		                        secondLatLong: (1,1))
	}
	
	func test_Locations_WhenNamesEqual_AreEqual() {
		performEqualTestWith(firstName: "Foo", secondName: "Foo", firstLatLong: (1,1), secondLatLong: (1,1))
	}
	
	func performEqualTestWith(firstName: String,
	                             secondName: String,
	                             firstLatLong: (Double, Double)?,
	                             secondLatLong: (Double, Double)?,
	                             line: UInt = #line) {
		
		var firstCoordinate: CLLocationCoordinate2D? = nil
		if let firstLatLong = firstLatLong {
			firstCoordinate = CLLocationCoordinate2D(latitude: firstLatLong.0, longitude: firstLatLong.1)
		}
		let firstLocation = Location(name: firstName, coordinate: firstCoordinate)
		
		var secondCoordinate: CLLocationCoordinate2D? = nil
		if let secondLatLong = secondLatLong {
			secondCoordinate = CLLocationCoordinate2D(latitude: secondLatLong.0, longitude: secondLatLong.1)
		}
		let secondLocation = Location(name: secondName, coordinate: secondCoordinate)
		
		XCTAssertEqual(firstLocation, secondLocation)
	}
}
