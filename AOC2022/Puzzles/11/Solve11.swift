
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example11") == 0
	}

	func solveBExamples() -> Bool {
		return solveB("Example11") == 0
	}

	var answerA = "10605"
	var answerB = ""

	func solveA() -> String {
		solveA("Input11").description
	}

	func solveB() -> String {
		solveB("Input11").description
	}
	
	/*
	 Monkey 0:
	   Starting items: 79, 98
	   Operation: new = old * 19
	   Test: divisible by 23
		 If true: throw to monkey 2
		 If false: throw to monkey 3
	 */
	class Monkey {
		init(id: Int, items: [Int], operation: Operation, factor: Int?, divisor: Int, trueTarget: Int, falseTarget: Int) {
			self.id = id
			self.items = items
			self.operation = operation
			self.factor = factor
			self.divisor = divisor
			self.trueTarget = trueTarget
			self.falseTarget = falseTarget
		}
		var id: Int
		var items: [Int]
		enum Operation {
			case add
			case multiply
		}
		var operation: Operation
		// nil means use old value
		var factor: Int?
		var divisor: Int
		var trueTarget: Int
		var falseTarget: Int
	}

	func solveA(_ fileName: String) -> Int {
		var monkies = load(fileName)
		return monkies.count
	}

	func solveB(_ fileName: String) -> Int {
		var lines = FileHelper.load(fileName)!
		return lines.count
	}
	
	func load(_ fileName: String) -> [Monkey] {
		var monkies: [Monkey] = []
		let lines = FileHelper.loadAndTokenize(fileName)
		for index in stride(from: 0, to: lines.count, by: 6) {
			// Monkey 0:
			let id = Int(String(lines[index][1].character(at: 0)))!

			// Starting items: 79, 98
			var items: [Int] = []
			for itemIndex in 4 ..< lines[index + 1].count {
				var itemStr = lines[index + 1][itemIndex]
				if itemStr.last == "," {
					itemStr = String(itemStr.dropLast(1))
				}
				items.append(Int(itemStr)!)
			}
			
			//  Operation: new = old * 19
			let oper: Monkey.Operation = lines[index + 2][6] == "*" ? .multiply : .add
			let factorStr = lines[index + 2][7]
			let factor = factorStr == "old" ? nil : Int(factorStr)!
			
			// Test: divisible by 23
			let divisor = Int(lines[index + 3][5])!
			
			// If true: throw to monkey 2
			let trueTarget = Int(lines[index + 4][9])!

			// If false: throw to monkey 3
			let falseTarget = Int(lines[index + 5][9])!

			let monkey = Monkey(id: id, items: items, operation: oper, factor: factor, divisor: divisor, trueTarget: trueTarget, falseTarget: falseTarget)
			monkies.append(monkey)
		}
		return monkies
	}
}
