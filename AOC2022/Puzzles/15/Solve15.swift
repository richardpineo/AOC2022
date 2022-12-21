
import AOCLib
import Foundation

class Solve15: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example15", row: 10) == 26
	}

	func solveBExamples() -> Bool {
		return solveB("Example15", maxCoord: 20) == 56_000_011
	}

//	var shouldTestA = false
	
	var answerA = "5142231"
	var answerB = ""

	func solveA() -> String {
		solveA("Input15", row: 2_000_000).description
	}

	func solveB() -> String {
		""
	//	solveB("Input15", maxCoord: 4000000).description
	}

	struct Sensor {
		var position: Position2D
		var beacon: Position2D

		func covered(_ other: Position2D) -> Bool {
			abs(other.x - position.x) + abs(other.y - position.y) <= position.cityDistance(beacon)
		}
		
		func coverage(for row: Int) -> ClosedRange<Int>? {
			let distance = position.cityDistance(.init(position.x, row))
			let yDist = position.cityDistance(beacon) - distance
			if yDist <= 0 {
				return nil
			}
			return position.x - yDist ... position.x + yDist
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
	
	func findCoverage(_ sensors: [Sensor], for row: Int) -> [ClosedRange<Int>] {
		sensors.compactMap {
			$0.coverage(for: row)
		}
	}
	func isCovered( coverage: [ClosedRange<Int>], val: Int) -> Bool {
		coverage.first { $0.contains(val )} != nil
	}

	func solveA(_ fileName: String, row: Int) -> Int {
		let sensors = load(fileName)

		var minX = Int.max
		var maxX = Int.min
		var beacons: Set<Position2D> = .init()
		
		sensors.forEach {
			let bBox = $0.boundingBox
			minX = min(minX, bBox.0.x)
			maxX = max(maxX, bBox.1.x)
			beacons.insert($0.beacon)
		}
		
		let coverage = findCoverage(sensors, for: row)
		
		var count = 0
		for x in minX ... maxX {
			let pos: Position2D = .init(x, row)
			if beacons.contains(pos) {
				continue
			}
			
			if isCovered(coverage: coverage, val: x) {
				count += 1
			}
		}

		return count
	}

	func solveB(_ fileName: String, maxCoord: Int) -> Int {
		let sensors = load(fileName)

		for x in 0 ... maxCoord {
			for y in 0 ... maxCoord {
				let notCovered = sensors.allSatisfy {
					!$0.covered(.init(x,y))
				}
				if notCovered {
					return x * 4000000 + y
				}
			}
		}
		return -666
	}
}
