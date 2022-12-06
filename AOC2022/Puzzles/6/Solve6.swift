
import AOCLib
import Foundation
import RegexBuilder

class Solve6: PuzzleSolver {
	let examplesA = [
		("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7),
		("bvwbjplbgvbhsrlpgdmjqwftvncz", 5),
		("nppdvjthqldpwncqszvftbrmjlhg", 6),
		("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10),
		("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11),
	]
	
	func solveAExamples() -> Bool {
		examplesA.allSatisfy { solveA($0.0) == $0.1 }
	}

	func solveBExamples() -> Bool {
		true
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
//		solve("Input6")
		""
	}

	func solveB() -> String {
		//	solve("Input5", 9, retainOrder: true)
		""
	}
	
	func solveA(_ input: String) -> Int {
		for index in (4...) {
			let subStr = String(input.subString(start: index-4, count: 4))
			if subStr.isUnique {
				return index
			}
		}
		return 0
	}
}
