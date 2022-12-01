
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

	class Elf {
		init(_ food: [Int] = []) {
			self.food = food
		}

		var calories: Int {
			food.reduce(0, +)
		}

		var food: [Int]
	}

	func solveA(_ fileName: String) -> Int {
		let results = callElves(fileName)
		return results.map(\.calories).reduce(0, max)
	}

	func solveB(_ fileName: String) -> Int {
		let results = callElves(fileName).sorted(by: { $0.calories > $1.calories })
		return results[...2].map(\.calories).reduce(0, +)
	}

	func callElves(_ fileName: String) -> [Elf] {
		let input = FileHelper.load(fileName)!.map { Int($0) }
		let elfSource = input.split { $0 == nil }
		return elfSource.map { Elf($0.compactMap { $0 }) }
	}
}
