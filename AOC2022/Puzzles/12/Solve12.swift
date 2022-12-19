
import AOCLib
import Foundation

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example12") == 31
	}

	func solveBExamples() -> Bool {
		return solveB("Example12") == 29
	}

	var answerA = "412"
	var answerB = "402"

	func solveA() -> String {
		solveA("Input12").description
	}

	func solveB() -> String {
		solveB("Input12").description
	}

	func solveA(_ fileName: String) -> Int {
		let hill = Hill(fileName: fileName)
		return hill.traverseFromStart()
	}

	func solveB(_ fileName: String) -> Int {
		let hill = Hill(fileName: fileName)
		return hill.traverseFromLowlands()
	}

	class Hill {
		init(fileName: String) {
			let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
			heights = .init(maxPos: .init(lines[0].count, lines.count), initialValue: -1)
			start = .origin
			end = .origin

			for y in 0 ..< lines.count {
				for x in 0 ..< lines[y].count {
					var value = lines[y].character(at: x)
					if value == "S" {
						value = Character("a")
						start = .init(x, y)
					} else if value == "E" {
						value = Character("z")
						end = .init(x, y)
					}
					heights.setValue(.init(x, y), Int(value.asciiValue! - Character("a").asciiValue!))
				}
			}
		}

		var heights: Grid2D
		var start: Position2D
		var end: Position2D

		let unknown: Int = -1

		func traverseFromStart() -> Int {
			let traverseMap = buildTraverseMap()
			return traverseMap.value(start)
		}

		func traverseFromLowlands() -> Int {
			let traverseMap = buildTraverseMap()
			let lowlands = heights.allPositions.filter { heights.value($0) == 0 }
			let fastest = lowlands.reduce(Int.max) {
				let value = traverseMap.value($1)
				if value == unknown {
					return $0
				}
				return min($0, value)
			}
			return fastest
		}

		private func buildTraverseMap() -> Grid2D {
			var positions: Queue<Position2D> = .init(from: [end])
			var traverseMap = Grid2D(maxPos: heights.maxPos, initialValue: unknown)

			var steps = 0
			while !positions.isEmpty {
				var positionCountForStep = positions.count
				while positionCountForStep > 0 {
					let current = positions.dequeue()!
					positionCountForStep -= 1

					traverseMap.setValue(current, steps)

					[current.offset(.south), current.offset(.east), current.offset(.north), current.offset(.west)]
						.filter {
							heights.valid($0) &&
								traverseMap.value($0) == unknown &&
								heights.value(current) - heights.value($0) < 2 &&
								!positions.array.contains($0)
						}.forEach {
							positions.enqueue($0)
						}
				}
				steps += 1
			}

			return traverseMap
		}
	}
}
