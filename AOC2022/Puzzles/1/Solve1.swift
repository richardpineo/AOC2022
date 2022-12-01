
import AOCLib
import Foundation

class Solve1: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example1") == 24000
	}

	func solveBExamples() -> Bool {
		solveB("Example1") == 45000
	}

	var answerA = "69626"
	var answerB = "206780"

	func solveA() -> String {
		solveA("Input1").description
	}

	func solveB() -> String {
		solveB("Input1").description
	}
	
	class Result {
		var total: Int {
			food.reduce(0, +)
		}
		var food: [Int] = []
	}
	
	func solveA(_ fileName: String) -> Int {
		let results = gather(fileName)
		return results.map(\.total).reduce(0, max)
	}
	
	func solveB(_ fileName: String) -> Int {
		let results = gather(fileName).sorted(by: { $0.total > $1.total })
		return results[0].total + results[1].total + results[2].total
	}

	func gather(_ fileName: String) -> [Result] {
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
		return results
	}
}
