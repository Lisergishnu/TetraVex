//
//  TVHighScoreViewController.swift
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

class TVHighScoreViewController : NSViewController, NSTableViewDelegate, NSTableViewDataSource {
	
	@IBOutlet weak var tableView: NSTableView!

	var selectedSize: String = "2x2"
	var scores: TVHighScores?
	var dates: [NSDate]?

	var dateFmt: DateFormatter?

	override func viewDidLoad() {
		scores = TVHighScores.read()
		reload()

		dateFmt = DateFormatter()
		dateFmt?.timeZone = TimeZone.current
		dateFmt?.dateFormat = "yyyy-MM-dd HH:mm:ss"

		tableView.delegate = self
		tableView.dataSource = self
	}

	func reload() {
		dates = Array((scores?.scores![selectedSize]!.keys)!).sorted(by: { date1, date2 in
			return scores!.scores![selectedSize]![date1]! < scores!.scores![selectedSize]![date2]!
		})
		tableView.reloadData()
	}

	func numberOfRows(in tableView: NSTableView) -> Int {
		return dates!.count
	}

	func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if (tableColumn?.identifier)!.rawValue == "Date-Time" {
			return dateFmt?.string(from: dates![row] as Date)
		} else {
			return TVHighScores.timeToString(scores!.scores![selectedSize]![dates![row]]!)
		}
	}

	@IBAction func deleteScores(_ sender: Any) {
		let alert = NSAlert()
		alert.messageText = "Are you sure you want to delete your high scores? This cannot be undone."
		alert.addButton(withTitle: "No")
		alert.addButton(withTitle: "Yes")
		if alert.runModal() == NSApplication.ModalResponse.alertSecondButtonReturn {
			scores?.scores = TVHighScores.emptyScores
			scores?.save()
			reload()
		}
	}

	@IBAction func sizeChooser(_ sender: NSPopUpButton) {
		selectedSize = sender.titleOfSelectedItem!
		reload()
	}

}
