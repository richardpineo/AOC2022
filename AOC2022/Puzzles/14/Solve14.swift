
import AOCLib
import Foundation

class Solve14: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example14") == 24
	}

	func solveBExamples() -> Bool {
		return solveB("Example14") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input14").description
	}

	func solveB() -> String {
		solveB("Input14").description
	}
	
	class Environment {
		enum Content {
			case nothing
			case rock
			case sand
		}
		
		var contents: [Position2D: Content] = [:]
		
		func addRock(_ a: Position2D, _ b: Position2D) {
			if a.x == b.x {
				for y in min(a.y, b.y) ... max(a.y, b.y) {
					contents[.init(a.x, y)] = .rock
				}
			} else {
				for x in min(a.x, b.x) ... max(a.x, b.x) {
					contents[.init(x, a.y)] = .rock
				}
			}
		}
	}
	
	func solveA(_ fileName: String) -> Int {
		let env = load(fileName)
		return env.contents.count
	}

	func solveB(_: String) -> Int {
		0
	}
	
	func load(_ fileName: String) -> Environment {
		let lines = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let env: Environment = .init()
		lines.forEach {
			let endPoints = $0.split(separator: " -> ")
			for index in 0 ..< endPoints.count - 1 {
				let a = Position2D(from: String(endPoints[index]))
				let b = Position2D(from: String(endPoints[index + 1]))
				env.addRock(a, b)
			}
		}
		return env
	}
}
