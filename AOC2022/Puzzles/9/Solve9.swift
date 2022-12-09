
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
	
	struct Motion {
		var distance: Int
		var direction: Heading
	}
	
	func load(_ fileName: String) -> [Motion] {
		func parseDirection(_ str: String ) -> Heading{
			switch str {
			case "U": return .north
			case "D": return .south
			case "L": return .west
			case "R": return .east
			default:
				exit(1)
			}
		}
		let lines = FileHelper.loadAndTokenize(fileName)
		return lines.map {
			.init(distance: Int($0[1])!, direction: parseDirection($0[0]))
		}
	}
	
	func solveA(_ fileName: String) -> Int {
		let motions = load(fileName)
		return motions.count
	}
	
	func solveB(_ fileName: String) -> Int {
		0
	}
}
