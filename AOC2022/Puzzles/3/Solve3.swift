
import AOCLib
import Foundation

class Solve3: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example3") == 157
	}

	func solveBExamples() -> Bool {
		solveB("Example3") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input3").description
	}

	func solveB() -> String {
		solveB("Input3").description
	}
	
	struct Rucksack {
		var pocket1: String
		var pocket2: String
		
		var commonItem: Character {
			let found = pocket1.first {
				pocket2.contains($0)
			}
			return found!
		}
	}
	
	func score(of item: Character) -> Int {
		let itemVal = item.asciiValue!
		let aVal = Character("a").asciiValue!
		let zVal = Character("z").asciiValue!
		let AVal = Character("A").asciiValue! - 26
		let startCharacter = itemVal >= aVal && itemVal <= zVal ? aVal : AVal
		return Int(itemVal - startCharacter + 1)
	}

	func solveA(_ fileName: String) -> Int {
		let rucksacks: [Rucksack] = FileHelper.load(fileName)!.filter { !$0.isEmpty }.map {
			return .init(
				pocket1: $0.subString(start: 0, count: $0.count/2),
				pocket2: $0.subString(start: $0.count/2, count: $0.count/2))
		}
		return rucksacks.reduce(0) {
			$0 + score(of: $1.commonItem)
		}
	}
	
	func solveB(_ fileName: String) -> Int {
		0
	}
}
