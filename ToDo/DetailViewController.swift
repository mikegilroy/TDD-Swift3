//
//  DetailViewController.swift
//  ToDo
//
//  Created by Mike Gilroy on 19/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController {

	var itemInfo: (ItemManager, Int)?
	
	let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"
		return dateFormatter
	}()
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var checkButton: UIButton!
	@IBOutlet weak var mapView: MKMapView!
	
	@IBAction func checkButtonTapped(_ sender: Any) {
		checkItem()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		guard let itemInfo = itemInfo else { return }
		let item = itemInfo.0.item(at: itemInfo.1)
		
		titleLabel.text = item.title
		locationLabel.text = item.location?.name
		descriptionLabel.text = item.description
		
		if let timestamp = item.timestamp {
			let date = Date(timeIntervalSince1970: timestamp)
			dateLabel.text = dateFormatter.string(from: date)
		}
		
		if let coordinate = item.location?.coordinate {
			let region = MKCoordinateRegionMakeWithDistance(coordinate, 100, 100)
			mapView.region = region
		}
	}
	
	func checkItem() {
		if let itemInfo = itemInfo {
			itemInfo.0.checkItem(at: itemInfo.1)
		}
	}

}
