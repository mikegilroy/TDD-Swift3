//
//  ItemCell.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	lazy var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/dd/yyyy"
		return dateFormatter
	}()
	
	func configCell(with item: ToDoItem, isChecked: Bool = false) {
		
		if isChecked {
			let attributedTitle = NSAttributedString(string: item.title, attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
			titleLabel.attributedText = attributedTitle
			
			dateLabel.text = nil
			locationLabel.text = nil
		} else {
			titleLabel.text = item.title
			locationLabel.text = item.location?.name
			
			if let timestamp = item.timestamp {
				let date = Date(timeIntervalSince1970: timestamp)
				dateLabel.text = dateFormatter.string(from: date)
			}
		}
	}
}
