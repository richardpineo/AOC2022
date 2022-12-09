
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
		
	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.loadAndTokenize(fileName)
		return lines.count
	}
	
	func solveB(_ fileName: String) -> Int {
		0
	}
}
