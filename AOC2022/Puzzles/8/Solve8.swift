
import AOCLib
import Foundation

class Solve8: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example8") == 21
	}

	func solveBExamples() -> Bool {
		solveB("Example8") == 8
	}

	var answerA = "1782"
	var answerB = "474606"

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
	
	func numVisible(_ pos: Position2D, _ move: Position2D, _ grid: Grid2D) -> Int {
		let val = grid.value(pos)
		var nextPos = pos.offset(move)
		if !grid.valid(nextPos) {
			return 0
		}
		var count = 1
		while(grid.valid(nextPos)) {
			if grid.value(nextPos) >= val {
				return count
			}
			nextPos = nextPos.offset(move)
			if !grid.valid(nextPos) {
				return count
			}
			count += 1
		}
		return count
	}
	
	func scenicScore(_ pos: Position2D, _ grid: Grid2D) -> Int {
		let offsets: [Position2D] = [.init(1, 0), .init(-1, 0), .init(0,1), .init(0,-1)]
//		let nums = offsets.map { numVisible(pos, $0, grid ) }
		let score = offsets.reduce(1) { $0 * numVisible(pos, $1, grid ) }
//		print("\(pos.displayString): \(grid.value(pos)) = \(score)")
		return score
	}

	func solveB(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
	//	let _ = scenicScore(.init(2,3), grid)
		return grid.allPositions.map { scenicScore($0, grid) }.max()!
	}
}
