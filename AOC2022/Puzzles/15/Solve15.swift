
import AOCLib
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15") == 26
	}

	func solveBExamples() -> Bool {
		return solveB("Example15") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input15").description
	}

	func solveB() -> String {
		solveB("Input15").description
	}
	
	struct Sensor {
		var position: Position2D
		var beacon: Position2D
	}
	
	func load(_ fileName: String) -> [Sensor] {
		let lines = FileHelper.loadAndTokenize (fileName)
		return lines.map { tokens in
			let posX = tokens[2].subString(start: 2, count: tokens[2].count - 3)
			let posY = tokens[3].subString(start: 2, count: tokens[3].count - 3)
			let beaconX = tokens[8].subString(start: 2, count: tokens[8].count - 3)
			let beaconY = tokens[9].subString(start: 2, count: tokens[9].count - 2)
			return .init(
				position: .init(Int(posX)!, Int(posY)!),
				beacon: .init(Int(beaconX)!, Int(beaconY)!))
		}
	}

	func solveA(_ fileName: String) -> Int {
		let sensors = load(fileName)
		
		return sensors.count
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
