//
//  ItemListDataProvider.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import Foundation
import UIKit

class ItemListDataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
	
	enum Section: Int {
		case toDoItems = 0
		case doneItems = 1
	}
	
	var itemManager: ItemManager?
	
	
	// MARK: - UITableViewDataSource
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard  let itemManager = itemManager else { return 0 }
		guard let section = Section(rawValue: section) else {
			fatalError()
		}
		
		switch section {
		case .toDoItems:
			return itemManager.toDoCount
		case .doneItems:
			return itemManager.doneCount
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let itemManager = itemManager else { fatalError() }
		guard let section = Section(rawValue: indexPath.section) else {
			fatalError()
		}
	
		let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
		
		let item: ToDoItem
		switch section {
		case .toDoItems:
			item = itemManager.item(at: indexPath.row)
			cell.configCell(with: item)
		case .doneItems:
			item = itemManager.doneItem(at: indexPath.row)
			cell.configCell(with: item, isChecked: true)
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		guard let itemManager = itemManager else {
			fatalError()
		}
		guard let section = Section(rawValue: indexPath.section) else {
			fatalError()
		}
		
		switch section {
		case .toDoItems:
			itemManager.checkItem(at: indexPath.row)
		case .doneItems:
			itemManager.uncheckItem(at: indexPath.row)
		}
		
	}
	
	// MARK: - UITableViewDelegate
	
	func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
		guard let section = Section(rawValue: indexPath.section) else {
			fatalError()
		}
		switch section {
		case .toDoItems:
			return "Check"
		case .doneItems:
			return "Uncheck"
		}
	}
}
