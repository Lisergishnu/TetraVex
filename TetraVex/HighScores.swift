//
//  HighScores.swift
//  TetraVex
//
//  Created by Alessandro Vinciguerra on 08/08/2017.
//  Copyright © 2017 Marco Benzi Tobar. All rights reserved.
//

import Foundation

class HighScores: NSObject, NSCoding {

	var scores: [NSDate : Int]?

	init(_ scores: [NSDate : Int]) {
		self.scores = scores
	}

	//MARK: - En/Decoding
	func encode(with aCoder: NSCoder) {
		aCoder.encode(scores)
	}

	required convenience init?(coder aDecoder: NSCoder) {
		guard let scores = aDecoder.decodeObject() as? [NSDate:Int] else {
			return nil
		}
		self.init(scores)
	}

	//MARK: - Saving/Reading
	func save() {
		let data = NSKeyedArchiver.archivedData(withRootObject: self)
		UserDefaults.standard.set(data, forKey: "HighScore")
	}

	static func read() -> HighScores {
		guard let data = UserDefaults.standard.object(forKey: "HighScore") as? Data else {
			return HighScores([:])
		}
		return NSKeyedUnarchiver.unarchiveObject(with: data) as! HighScores
	}

}
