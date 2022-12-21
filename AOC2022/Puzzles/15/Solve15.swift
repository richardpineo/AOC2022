
import AOCLib
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15", row: 10) == 26
	}

	func solveBExamples() -> Bool {
		return solveB("Example15") == 56_000_011
	}

	var answerA = "5142231"
	var answerB = ""

	func solveA() -> String {
		solveA("Input15", row: 2_000_000).description
	}

	func solveB() -> String {
		solveB("Input15").description
	}

	struct Sensor {
		var position: Position2D
		var beacon: Position2D

		func covered(_ other: Position2D) -> Bool {
			abs(other.x - position.x) + abs(other.y - position.y) <= position.cityDistance(beacon)
		}

		var boundingBox: (Position2D, Position2D) {
			let maxDistance = position.cityDistance(beacon)
			return (.init(position.x - maxDistance, position.y - maxDistance),
			        .init(position.x + maxDistance, position.y + maxDistance))
		}
	}

	func load(_ fileName: String) -> [Sensor] {
		let lines = FileHelper.loadAndTokenize(fileName)
		return lines.map { tokens in
			let posX = tokens[2].subString(start: 2, count: tokens[2].count - 3)
			let posY = tokens[3].subString(start: 2, count: tokens[3].count - 3)
			let beaconX = tokens[8].subString(start: 2, count: tokens[8].count - 3)
			let beaconY = tokens[9].subString(start: 2, count: tokens[9].count - 2)
			return .init(
				position: .init(Int(posX)!, Int(posY)!),
				beacon: .init(Int(beaconX)!, Int(beaconY)!)
			)
		}
	}

	func solveA(_ fileName: String, row: Int) -> Int {
		let sensors = load(fileName)

		var minX = Int.max
		var maxX = Int.min
		sensors.forEach {
			let bBox = $0.boundingBox
			minX = min(minX, bBox.0.x)
			maxX = max(maxX, bBox.1.x)
		}
		var count = 0
		for x in minX ... maxX {
			let pos: Position2D = .init(x, row)
			let notBeacon = sensors.allSatisfy {
				$0.beacon != pos
			}
			if notBeacon {
				let covered = !sensors.allSatisfy {
					!$0.covered(pos) && $0.beacon != pos
				}
				count += covered ? 1 : 0
			}
		}

		return count
	}

	func solveB(_: String) -> Int {
		0
	}
}
