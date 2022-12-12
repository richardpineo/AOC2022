
import AOCLib
import Foundation

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example12") == 31
	}
	
	func solveBExamples() -> Bool {
		return solveB("Example12") == 0
	}
	
	var answerA = ""
	var answerB = ""
	
	func solveA() -> String {
		solveA("Input12").description
	}
	
	func solveB() -> String {
		solveB("Input12").description
	}
	
	func solveA(_ fileName: String) -> Int {
		let lines = FileHelper.load(fileName)!.filter { $0.isEmpty }
		return lines.count
	}
	
	func solveB(_ fileName: String) -> Int {
		0
	}	
}
