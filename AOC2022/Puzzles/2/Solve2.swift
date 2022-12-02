
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == 15
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == 0
	}

	var answerA = "12794"
	var answerB = ""

	func solveA() -> String {
		solveA("Input2").description
	}

	func solveB() -> String {
		solveB("Input2").description
	}

	func solveA(_ fileName: String) -> Int {
		let strategy = loadStrategy(fileName)
		return strategy.reduce(0) {
			$0 + $1.us.beats($1.them) + $1.us.points
		}
	}

	func solveB(_ fileName: String) -> Int {
		let strategy = loadStrategy(fileName)
		return 0
	}

	enum Choice {
		case rock
		case paper
		case scissors

		var points: Int {
			switch self {
			case .rock: return 1
			case .paper: return 2
			case .scissors: return 3
			}
		}

		func beats(_ c: Choice) -> Int {
			switch self {
			case .rock:
				switch c {
				case .rock:
					return 3
				case .paper:
					return 0
				case .scissors:
					return 6
				}

			case .paper:
				switch c {
				case .rock:
					return 6
				case .paper:
					return 3
				case .scissors:
					return 0
				}

			case .scissors:
				switch c {
				case .rock:
					return 0
				case .paper:
					return 6
				case .scissors:
					return 3
				}
			}
		}

		static func parse(_ val: String) -> Choice {
			switch val {
			case "A", "X": return .rock
			case "B", "Y": return .paper
			case "C", "Z": return .scissors
			default:
				exit(0)
			}
		}
	}

	struct Strategy {
		var them: Choice
		var us: Choice
	}

	func loadStrategy(_ fileName: String) -> [Strategy] {
		let plays = FileHelper.loadAndTokenize(fileName)
		return plays.map {
			.init(them: Choice.parse($0[0]), us: Choice.parse($0[1]))
		}
	}
}
