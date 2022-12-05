
import AOCLib
import Foundation

class Solve5: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example4") == "CMZ"
	}

	func solveBExamples() -> Bool {
		solveB("Example4") == ""
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input4")
	}

	func solveB() -> String {
		solveB("Input4")
	}
	
	struct CrateStack {
		var id: Int
		var crates: [String]
	}
	
	struct Order {
		var count: Int
		var from: Int
		var to: Int
	}
	
	func load(_ fileName: String) -> [Int] {
		let raw = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return [raw.count]
	}

	func solveA(_ fileName: String) -> String {
		return load(fileName).description
 	}

	func solveB(_ fileName: String) -> String {
		return load(fileName).description
	}
}
