
import AOCLib
import Foundation

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example8") == 21
	}

	func solveBExamples() -> Bool {
		solveB("Example8") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input8").description
	}

	func solveB() -> String {
		solveB("Input8").description
	}
	
	func isVisibleFrom(_ pos: Position2D, _ move: Position2D, _ grid: Grid2D) -> Bool {
		let val = grid.value(pos)
		var nextPos = pos.offset(move)
		while(grid.valid(nextPos)) {
			if grid.value(nextPos) >= val {
				return false
			}
			nextPos = nextPos.offset(move)
		}
		return true
	}
	
	func isVisible(_ pos: Position2D, _ grid: Grid2D) -> Bool {
		let offsets: [Position2D] = [.init(1, 0), .init(-1, 0), .init(0,1), .init(0,-1)]
		let found = offsets.first { isVisibleFrom(pos, $0, grid ) }
		return found != nil
	}
	
	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		return grid.allPositions.filter { isVisible($0, grid) }.count
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
