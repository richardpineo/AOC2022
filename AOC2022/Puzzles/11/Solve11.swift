
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example11") == 0
	}

	func solveBExamples() -> Bool {
		return solveB("Example11") == 0
	}

	var answerA = "10605"
	var answerB = ""

	func solveA() -> String {
		solveA("Input11").description
	}

	func solveB() -> String {
		solveB("Input11").description
	}

	func solveA(_ fileName: String) -> Int {
		var lines = FileHelper.load(fileName)!
		return lines.count
	}

	func solveB(_ fileName: String) -> Int {
		var lines = FileHelper.load(fileName)!
		return lines.count
	}
}
