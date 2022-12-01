
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		solve("Example1") == 24000
	}

	func solveBExamples() -> Bool {
		true
		// solveB("Example1") == 5
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solve("Input1").description
	}

	func solveB() -> String {
		""//solveB("Input1").description
	}
	
	class Result {
		var total: Int {
			food.reduce(0, +)
		}
		var food: [Int] = []
	}

	func solve(_ fileName: String) -> Int {
		let input = FileHelper.load(fileName)!
		var results: [Result] = []
		var result: Result = .init()
		for index in 0..<input.count {
			if let food = Int(input[index]) {
				result.food.append(food)
			} else {
				results.append(result)
				result = .init()
			}
		}
		return results.map(\.total).reduce(0, max)
	}
}
