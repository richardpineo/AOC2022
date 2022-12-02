
import AOCLib
import Foundation

class Solve2: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example2") == 15
	}

	func solveBExamples() -> Bool {
		solveB("Example2") == 12
	}

	var answerA = "12794"
	var answerB = "14979"

	func solveA() -> String {
		solveA("Input2").description
	}

	func solveB() -> String {
		solveB("Input2").description
	}

	struct StrategyA {
		var them: Choice
		var us: Choice
	}

	func solveA(_ fileName: String) -> Int {
		let plays = FileHelper.loadAndTokenize(fileName)
		let strategy: [StrategyA] = plays.map {
			.init(them: Choice.parse($0[0]), us: Choice.parse($0[1]))
		}
		return strategy.reduce(0) { total, strategy in
			total + strategy.us.shoot(strategy.them).rawValue + strategy.us.rawValue
		}
	}

	struct StrategyB {
		var them: Choice
		var result: Result
	}

	func solveB(_ fileName: String) -> Int {
		let plays = FileHelper.loadAndTokenize(fileName)
		let strategy: [StrategyB] = plays.map {
			.init(them: Choice.parse($0[0]), result: Result.parse($0[1]))
		}
		return strategy.reduce(0) {
			$0 + $1.them.needed(to: $1.result).rawValue + $1.result.rawValue
		}
	}

	enum Result: Int {
		case lose = 0
		case draw = 3
		case win = 6

		static func parse(_ val: String) -> Result {
			switch val {
			case "X": return .lose
			case "Y": return .draw
			case "Z": return .win
			default:
				exit(0)
			}
		}
	}

	enum Choice: Int {
		case rock = 1
		case paper = 2
		case scissors = 3

		func needed(to: Result) -> Choice {
			let tries: [Choice] = [.rock, .paper, .scissors]
			return tries.first { $0.shoot(self) == to }!
		}

		func shoot(_ against: Choice) -> Result {
			switch (self, against) {
			case (.rock, .rock), (.paper, .paper), (.scissors, .scissors):
				return .draw
			case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
				return .lose
			case (.rock, .scissors), (.paper, .rock), (.scissors, .paper):
				return .win
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
}
