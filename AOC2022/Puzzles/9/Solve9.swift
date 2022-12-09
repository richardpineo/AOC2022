
import AOCLib
import Foundation

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example9") == 13
	}

	func solveBExamples() -> Bool {
		solveB("Example9") == 1 && solveB("Example9b") == 36
	}

	var answerA = "6367"
	var answerB = "2536"

	func solveA() -> String {
		solveA("Input9").description
	}

	func solveB() -> String {
		solveB("Input9").description
	}

	struct Motion {
		var distance: Int
		var direction: Heading
	}

	func load(_ fileName: String) -> [Motion] {
		func parseDirection(_ str: String) -> Heading {
			switch str {
			case "U": return .north
			case "D": return .south
			case "L": return .west
			case "R": return .east
			default:
				exit(1)
			}
		}
		let lines = FileHelper.loadAndTokenize(fileName)
		return lines.map {
			.init(distance: Int($0[1])!, direction: parseDirection($0[0]))
		}
	}

	func toMove(_ a: Int, _ b: Int) -> Int {
		if a == b {
			return 0
		}
		return a < b ? -1 : 1
	}

	func follow(_ leader: Position2D, _ follower: Position2D) -> Position2D {
		if abs(leader.x - follower.x) < 2, abs(leader.y - follower.y) < 2 {
			return follower
		}
		return follower.offset(toMove(leader.x, follower.x), toMove(leader.y, follower.y))
	}

	func solve(_ fileName: String, knots: Int) -> Int {
		let motions = load(fileName)
		var knotPositions: [Position2D] = .init(repeating: .origin, count: knots)
		var visited: Set<Position2D> = [.origin]

		motions.forEach {
			for _ in 1 ... $0.distance {
				knotPositions[0] = knotPositions[0].offset($0.direction)
				for index in 1 ..< knotPositions.count {
					knotPositions[index] = follow(knotPositions[index - 1], knotPositions[index])
				}
				visited.insert(knotPositions.last!)
			}
		}

		return visited.count
	}

	func solveA(_ fileName: String) -> Int {
		return solve(fileName, knots: 2)
	}

	func solveB(_ fileName: String) -> Int {
		solve(fileName, knots: 10)
	}
}
