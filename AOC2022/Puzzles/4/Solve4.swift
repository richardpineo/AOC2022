
import AOCLib
import Foundation

class Solve4: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example4") == 2
	}

	func solveBExamples() -> Bool {
		solveB("Example4") == 0
	}

	var answerA = "487"
	var answerB = ""

	func solveA() -> String {
		solveA("Input4").description
	}

	func solveB() -> String {
		solveB("Input4").description
	}

	struct ElfPair {
		struct Section {
			var start: Int
			var end: Int

			static func parse(_ s: String) -> Section {
				let tokens = s.components(separatedBy: "-")
				return .init(start: Int(tokens[0])!, end: Int(tokens[1])!)
			}
			func contains(_ other: Section) -> Bool {
				start <= other.start && end >= other.end
			}
		}

		var elf1: Section
		var elf2: Section
		
		var contains: Bool {
			elf1.contains(elf2) || elf2.contains(elf1)
		}
	}

	func load(_ fileName: String) -> [ElfPair] {
		let raw = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return raw.map {
			let pair = $0.components(separatedBy: ",")
			return .init(elf1: .parse(pair[0]), elf2: .parse(pair[1]))
		}
	}

	func solveA(_ fileName: String) -> Int {
		return load(fileName).filter { $0.contains }.count
 	}

	func solveB(_ fileName: String) -> Int {
		let raw = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		return raw.count
	}
}
