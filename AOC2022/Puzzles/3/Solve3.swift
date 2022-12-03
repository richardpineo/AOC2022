
import AOCLib
import Foundation

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 157
	}

	func solveBExamples() -> Bool {
		solveB("Example3") == 70
	}

	var answerA = "8176"
	var answerB = "2689"

	func solveA() -> String {
		solveA("Input3").description
	}

	func solveB() -> String {
		solveB("Input3").description
	}

	func score(of item: Character) -> Int {
		let itemVal = item.asciiValue!
		let aVal = Character("a").asciiValue!
		let zVal = Character("z").asciiValue!
		let AVal = Character("A").asciiValue! - 26
		let startCharacter = itemVal >= aVal && itemVal <= zVal ? aVal : AVal
		return Int(itemVal - startCharacter + 1)
	}

	struct Rucksack {
		var pocket1: String
		var pocket2: String

		var commonItem: Character {
			pocket1.first { pocket2.contains($0) }!
		}
	}

	func solveA(_ fileName: String) -> Int {
		let rucksacks: [Rucksack] = FileHelper.load(fileName)!.filter { !$0.isEmpty }.map {
			.init(
				pocket1: $0.subString(start: 0, count: $0.count / 2),
				pocket2: $0.subString(start: $0.count / 2, count: $0.count / 2)
			)
		}
		return rucksacks.reduce(0) { $0 + score(of: $1.commonItem) }
	}

	struct ElfGroup {
		var members: [String]
		var commonItem: Character {
			members[0].first { members[1].contains($0) && members[2].contains($0) }!
		}
	}

	func solveB(_ fileName: String) -> Int {
		let rawElves = FileHelper.load(fileName)!.filter { !$0.isEmpty }
		let elfGroups: [ElfGroup] = stride(from: 0, to: rawElves.count, by: 3).map {
			.init(members: Array(rawElves[$0 ... ($0 + 2)]))
		}
		return elfGroups.reduce(0) { $0 + score(of: $1.commonItem) }
	}
}
