
import AOCLib
import Foundation
import RegexBuilder

class Solve5: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example5", 3) == "CMZ"
	}

	func solveBExamples() -> Bool {
		solveB("Example5", 3) == "MCD"
	}

	var answerA = "PTWLTDSJV"
	var answerB = ""

	func solveA() -> String {
		solveA("Input5", 9)
	}

	func solveB() -> String {
		solveB("Input5", 9)
	}
	
	struct Order {
		var count: Int
		var from: Int
		var to: Int
	}
	
	class State {
		init(stacks: Int) {
			piles = [[Character]](repeating: [], count: stacks)
			
		}
		
		var orders: [Order] = []
		private var piles: [[Character]]
		
		func insert(pileIndex: Int, crate: Character) {
			piles[pileIndex].insert(crate, at: 0)
		}
		
		func move(from: Int, to: Int, count: Int) {
			let popped = (0 ..< count).map { _ in
				piles[from].popLast()!
			}
			popped.reversed().forEach {
				piles[to].append($0)
			}
		}
		
		func top(_ pileIndex: Int) -> Character {
			piles[pileIndex].last!
		}
	}
	
	func load(_ fileName: String, _ stacks: Int) -> State {
		let raw = FileHelper.load(fileName)!
		
		let index = raw.firstIndex { $0.isEmpty }!
		let state = State(stacks: stacks)

		raw[0..<(index-1)].forEach { row in
			for strIndex in stride(from: 1, to: row.count, by: 4) {
				let pileIndex = (strIndex - 1) / 4
				let crate = row.character(at: strIndex)
				if crate != " " {
					state.insert(pileIndex: pileIndex, crate: crate)
				}
			}
		}
		
		// move 1 from 2 to 1
		let moveRef = Reference(Int.self)
		let fromRef = Reference(Int.self)
		let toRef = Reference(Int.self)
		let commandPattern = Regex {
			"move "
			TryCapture(as: moveRef) {
				OneOrMore(.digit)
			} transform: {
				Int($0)
			}
			" from "
			TryCapture(as: fromRef) {
				OneOrMore(.digit)
			} transform: {
				Int($0)! - 1
			}
			" to "
			TryCapture(as: toRef) {
				OneOrMore(.digit)
			} transform: {
				Int($0)! - 1
			}
		}
		
		let range = raw[index...]
		state.orders = range.compactMap {
			guard let result = $0.firstMatch(of: commandPattern) else {
				return nil
			}
			return .init(count: result[moveRef], from: result[fromRef], to: result[toRef])
		}
		
		return state
	}

	func solveA(_ fileName: String, _ stacks: Int) -> String {
		let state = load(fileName, stacks)
		state.orders.forEach { order in
			for _ in 1...order.count {
				state.move(from: order.from, to: order.to, count: 1)
			}
		}
		
		let crates = (0 ..< stacks).map {
			String(state.top($0))
		}
		return String(crates.joined(separator: ""))
	}

	func solveB(_ fileName: String, _ stacks: Int) -> String {
		let state = load(fileName, stacks)
		state.orders.forEach { order in
			state.move(from: order.from, to: order.to, count: order.count)
		}
		
		let crates = (0 ..< stacks).map {
			String(state.top($0))
		}
		return String(crates.joined(separator: ""))
	}
}
