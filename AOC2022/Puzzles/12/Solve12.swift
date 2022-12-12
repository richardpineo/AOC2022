
import AOCLib
import Foundation

class Solve12: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example12") == 31
	}
	
	func solveBExamples() -> Bool {
		return solveB("Example12") == 0
	}
	
	var answerA = ""
	var answerB = ""
	
	func solveA() -> String {
		solveA("Input12").description
	}
	
	func solveB() -> String {
		solveB("Input12").description
	}
	
	class Hill {
		init(fileName: String) {
			let lines = FileHelper.load(fileName)!.filter{ !$0.isEmpty }
			heights = .init(maxPos: .init(lines[0].count, lines.count), initialValue: -1)
			start = .origin
			end = .origin

			for y in 0 ..< lines.count {
				for x in 0 ..< lines[y].count {
					var value = lines[y].character(at: x)
					if value == "S" {
						value = Character("a")
						start = .init(x, y)
					} else if value == "E" {
						value = Character("z")
						end = .init(x, y)
					}
					heights.setValue(.init(x, y), Int(value.asciiValue! - Character("a").asciiValue!))
				}
			}
		}
		
		var heights: Grid2D
		var start: Position2D
		var end: Position2D
	}
	
	func solveA(_ fileName: String) -> Int {
		let hill = Hill(fileName: fileName)
		
		return 0
	}
	
	func solveB(_ fileName: String) -> Int {
		0
	}
}
