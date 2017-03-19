//
//  ItemListViewController.swift
//  ToDo
//
//  Created by Mike Gilroy on 18/03/2017.
//  Copyright © 2017 Mike Gilroy. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var dataProvider: (UITableViewDataSource & UITableViewDelegate)!
	
	override func viewDidLoad() {
		tableView.dataSource = dataProvider
		tableView.delegate = dataProvider
	}
	
}
