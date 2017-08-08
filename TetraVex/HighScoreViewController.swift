//
//  HighScoreViewController.swift
//  TetraVex
//
//  Created by Alessandro Vinciguerra on 08/08/2017.
//  Copyright © 2017 Marco Benzi Tobar. All rights reserved.
//

import Cocoa

class HighScoreViewController : NSViewController, NSTableViewDelegate, NSTableViewDataSource {
	
	@IBOutlet weak var tableView: NSTableView!
	var scores: HighScores?
	var dates: [NSDate]?

	override func viewDidLoad() {
		scores = HighScores.read()
		dates = Array((scores?.scores?.keys)!)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.reloadData()
	}

	func numberOfRows(in tableView: NSTableView) -> Int {
		return dates!.count
	}

	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		if tableColumn?.identifier == "Date-Time" {
			return "\(dates![row])"
		} else {
			return "\((scores?.scores?[dates![row]])!)"
		}
	}

}
