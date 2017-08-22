//
//  HighScoreViewController.swift
//  TetraVex
//
//  Created by Alessandro Vinciguerra on 08/08/2017.
//
//  Copyright © 2017 Arc676/Alessandro Vinciguerra
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation (version 3)
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Cocoa

class HighScoreViewController : NSViewController, NSTableViewDelegate, NSTableViewDataSource {
	
	@IBOutlet weak var tableView: NSTableView!
	var scores: HighScores?
	var dates: [NSDate]?

	var dateFmt: DateFormatter?

	override func viewDidLoad() {
		scores = HighScores.read()
		dates = Array((scores?.scores?.keys)!).sorted(by: { date1, date2 in
			return (scores?.scores![date1])! < (scores?.scores![date2])!
		})

		dateFmt = DateFormatter()
		dateFmt?.timeZone = TimeZone.current
		dateFmt?.dateFormat = "yyyy-MM-dd HH:mm:ss"

		tableView.delegate = self
		tableView.dataSource = self
		tableView.reloadData()
	}

	func numberOfRows(in tableView: NSTableView) -> Int {
		return dates!.count
	}

	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
		if tableColumn?.identifier == "Date-Time" {
			return dateFmt?.string(from: dates![row] as Date)
		} else {
			return "\((scores?.scores?[dates![row]])!)"
		}
	}

}
