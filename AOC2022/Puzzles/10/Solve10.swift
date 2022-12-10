
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example10") == 13140
	}

	func solveBExamples() -> Bool {
		solveB("Example10") == 1
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input10").description
	}

	func solveB() -> String {
		solveB("Input10").description
	}
	
	enum Command {
		case noop
		case addx(Int)
	}
	
	func load(_ fileName: String) -> [Command] {
		FileHelper.loadAndTokenize(fileName).compactMap {
			switch $0[0] {
			case "noop": return .noop
			case "addx": return .addx(Int($0[1])!)
			default: return nil
			}
		}
	}

	func solveA(_ fileName: String) -> Int {
		let commands = load(fileName)
		return commands.count
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
