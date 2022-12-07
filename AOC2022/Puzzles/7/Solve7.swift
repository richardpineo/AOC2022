
import AOCLib
import Foundation

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example7") == 95437
	}

	func solveBExamples() -> Bool {
		false
	}

	var answerA = ""
	var answerB = ""
	
	func solveA() -> String {
		solveA("Input7").description
	}

	func solveB() -> String {
		""
	}

	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName)
		return lines.count
	}
}
