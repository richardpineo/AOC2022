
import AOCLib
import Foundation

class Solve9: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example9") == 13
	}

	func solveBExamples() -> Bool {
		solveB("Example9") == 0
	}

	var answerA = ""
	var answerB = ""

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

	func updateTail(_ head: Position2D, _ tail: Position2D) -> Position2D {
		if abs(head.x - tail.x) < 2, abs(head.y - tail.y) < 2 {
			return tail
		}
		return tail.offset(toMove(head.x, tail.x), toMove(head.y, tail.y))
	}

	func solveA(_ fileName: String) -> Int {
		let motions = load(fileName)
		var head: Position2D = .origin
		var tail: Position2D = .origin
		var visited: Set<Position2D> = [.origin]

		motions.forEach {
			for _ in 1 ... $0.distance {
				head = head.offset($0.direction)
				tail = updateTail(head, tail)
				visited.insert(tail)
			}
		}

		return visited.count
	}

	func solveB(_: String) -> Int {
		0
	}
}
