
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
		enum Content: String {
			case nothing = "."
			case rock = "#"
			case sand = "o"
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

		var highestRock: Int {
			contents.max {
				$0.key.y < $1.key.y
			}!.key.y
		}

		func isEmpty(_ pos: Position2D) -> Bool {
			switch contents[pos] {
			case .nothing, .none:
				return true
			case .sand, .rock:
				return false
			}
		}
		
		func debugPrint() {
			var topLeft: Position2D = contents.first!.key
			var bottomRight: Position2D = contents.first!.key
			contents.forEach {
				topLeft.x = min(topLeft.x, $0.key.x)
				topLeft.y = min(topLeft.y, $0.key.y)
				bottomRight.x = max(bottomRight.x, $0.key.x)
				bottomRight.y = max(bottomRight.y, $0.key.y)
			}
			for y in topLeft.y - 1 ... bottomRight.y + 1 {
				var line: String = ""
			for x in topLeft.x - 1 ... bottomRight.x + 1 {
					line.append(contents[.init(x,y) ]?.rawValue ?? ".")
				}
				print(line)
			}
		}
	}

	func dropSand(_ env: Environment, starting: Position2D = .init(500, 0)) -> Bool {
		var sandPos = starting
		while sandPos.y <= env.highestRock {
			if env.isEmpty(sandPos.offset(0, 1)) {
				sandPos = sandPos.offset(0, 1)
				continue
			}

			if env.isEmpty(sandPos.offset(-1, 1)) {
				sandPos = sandPos.offset(-1, 1)
				continue
			}
			if env.isEmpty(sandPos.offset(1, 1)) {
				sandPos = sandPos.offset(1, 1)
				continue
			}

			// leave it here
			env.contents[sandPos] = .sand
			return true
		}
		return false
	}

	func solveA(_ fileName: String) -> Int {
		let env = load(fileName)
		env.debugPrint()
		while dropSand(env) {
			// Wait
		}
		env.debugPrint()
		return env.contents.filter { $0.value == .sand }.count
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
