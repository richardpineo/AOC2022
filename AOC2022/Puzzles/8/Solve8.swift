
import AOCLib
import Foundation

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example7") == 21
	}

	func solveBExamples() -> Bool {
		solveB("Example7") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input8").description
	}

	func solveB() -> String {
		solveB("Input8").description
	}

	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { $0.isEmpty }
		return lines.count
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
