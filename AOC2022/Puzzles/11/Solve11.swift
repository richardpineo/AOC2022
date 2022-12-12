
import AOCLib
import Foundation

class Solve11: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example11") == 10605
	}

	func solveBExamples() -> Bool {
		return solveB("Example11") == 2713310158
	}

	var answerA = "55216"
	var answerB = "12848882750"

	func solveA() -> String {
		solveA("Input11").description
	}

	func solveB() -> String {
		solveB("Input11").description
	}

	class Monkey {
		init(id: Int, items: [Int], operation: Operation, factor: Int?, divisor: Int, trueTarget: Int, falseTarget: Int) {
			self.id = id
			self.items = .init(from: items)
			self.operation = operation
			self.factor = factor
			self.divisor = divisor
			self.trueTarget = trueTarget
			self.falseTarget = falseTarget
		}
		var id: Int
		var items: Queue<Int>
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
		var inspections: Int = 0
		
		func newWorry(old: Int) -> Int{
			let factor = factor ?? old
			switch operation {
			case .multiply:
				return old * factor
			case .add:
				return old + factor
			}
		}
		func target(worry: Int) -> Int {
			worry % divisor == 0 ? trueTarget : falseTarget
		}
	}

	func solveA(_ fileName: String) -> Int {
		let monkies = load(fileName)
		for _ in 0 ..< 20 {
			for monkey in monkies {
				while( !monkey.items.isEmpty ) {
					let old = monkey.items.dequeue()!
					let newWorry = monkey.newWorry(old: old)
					let postRelief = Int(newWorry / 3)
					let target = monkey.target(worry: postRelief)
					monkies[target].items.enqueue(postRelief)
					monkey.inspections += 1
				}
			}
		}
		let inspectionCounts = Array(monkies.map(\.inspections).sorted().reversed())
		return inspectionCounts[0] * inspectionCounts[1]
	}

	func solveB(_ fileName: String) -> Int {
		let monkies = load(fileName)
		let divisor = Int( MathHelper.lcm(of: monkies.map(\.divisor)))
		for round in 0 ..< 10000 {
			for monkey in monkies {
				while( !monkey.items.isEmpty ) {
					let old = monkey.items.dequeue()!
					let newWorry = monkey.newWorry(old: old)
					let postRelief = newWorry % divisor
					let target = monkey.target(worry: postRelief	)
					monkies[target].items.enqueue(postRelief)
					monkey.inspections += 1
				}
			}
		}
		let inspectionCounts = Array(monkies.map(\.inspections).sorted().reversed())
		return inspectionCounts[0] * inspectionCounts[1]
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
