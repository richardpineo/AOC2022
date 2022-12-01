
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

	struct Elf {
		var food: [Int]
		var calories: Int { food.reduce(0, +) }
	}

	func solveA(_ fileName: String) -> Int {
		let elves = callElves(fileName)
		return elves.map(\.calories).reduce(0, max)
	}

	func solveB(_ fileName: String) -> Int {
		// Sort biggest to smallest, take the first 3, return the sum of the calories.
		let elves = callElves(fileName).sorted(by: { $0.calories > $1.calories })
		return elves[...2].map(\.calories).reduce(0, +)
	}

	func callElves(_ fileName: String) -> [Elf] {
		let elfSource = FileHelper.load(fileName)!.map { Int($0) }.split { $0 == nil }
		return elfSource.map { Elf(food: $0.compactMap { $0 }) }
	}
}
