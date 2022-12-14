
import AOCLib
import Foundation

class Solve6: PuzzleSolver {
	let examples = [
		("mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7, 19),
		("bvwbjplbgvbhsrlpgdmjqwftvncz", 5, 23),
		("nppdvjthqldpwncqszvftbrmjlhg", 6, 23),
		("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10, 29),
		("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11, 26),
	]

	func solveAExamples() -> Bool {
		examples.allSatisfy { solve($0.0, numUnique: 4) == $0.1 }
	}

	func solveBExamples() -> Bool {
		examples.allSatisfy { solve($0.0, numUnique: 14) == $0.2 }
	}

	var answerA = "1779"
	var answerB = "2635"

	func solveA() -> String {
		solve(FileHelper.load("Input6")![0], numUnique: 4).description
	}

	func solveB() -> String {
		solve(FileHelper.load("Input6")![0], numUnique: 14).description
	}

	func solve(_ input: String, numUnique: Int) -> Int {
		return (numUnique ..< input.count).first {
			input.subString(start: $0 - numUnique, count: numUnique).isUnique
		}!
	}
}
