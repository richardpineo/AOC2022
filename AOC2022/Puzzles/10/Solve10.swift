
import AOCLib
import Foundation

class Solve10: PuzzleSolver {
	func solveAExamples() -> Bool {
		execute(commands: [.noop, .addx(3), .addx(-5)]).x(at: 6) == -1 &&
		solveA("Example10") == 13140
	}

	func solveBExamples() -> Bool {
		solveB("Example10") == 1
	}

	var answerA = "11720"
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
	
	class CPU {
		private var xAtCycle: [Int: Int] = [0: 1]
		private var cycle: Int = 0
		private var x: Int = 1
		
		func x(at cycle: Int) -> Int {
			var xVal = 0
			for index in 0..<cycle {
				if let val = xAtCycle[index] {
					xVal = val
				}
			}
			return xVal
		}
		
		func execute( _ command: Command) {
			cycle += 1
			switch command {
			case .noop:
				break
			case let .addx(xVal):
				cycle += 1
				x += xVal
				xAtCycle[cycle] = x
			}
		}
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
	
	func execute(commands: [Command]) -> CPU {
		let cpu = CPU()
		commands.forEach {
			cpu.execute($0)
		}
		return cpu
	}
	
	func solveA(_ fileName: String) -> Int {
		let cpu = execute(commands: load(fileName))
		
		let keyStrengths = stride(from: 20, to: 221, by: 40).map {
			($0, cpu.x(at: $0), $0 * cpu.x(at: $0))
		}

		return keyStrengths.map{ $0.2 }.reduce(0, +)
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
