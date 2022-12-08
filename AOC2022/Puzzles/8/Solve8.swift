
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
	
	func positionsInDirection(_ pos: Position2D, _ direction: Position2D, _ grid: Grid2D) -> [Position2D] {
		var positions: [Position2D] = []
		var nextPos = pos.offset(direction)
		while(grid.valid(nextPos)) {
			positions.append(nextPos)
			nextPos = nextPos.offset(direction)
		}
		return positions
	}
	
	var cardinalDirections: [Position2D] {
		[.init(1, 0), .init(-1, 0), .init(0,1), .init(0,-1)]
	}
	
	func isVisibleFrom(_ pos: Position2D, _ direction: Position2D, _ grid: Grid2D) -> Bool {
		return positionsInDirection(pos, direction, grid).allSatisfy { grid.value($0) < grid.value(pos) }
	}
	
	func isVisible(_ pos: Position2D, _ grid: Grid2D) -> Bool {
		return cardinalDirections.first { isVisibleFrom(pos, $0, grid ) } != nil
	}
	
	func solveA(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		return grid.allPositions.filter { isVisible($0, grid) }.count
	}
	
	func numVisible(_ pos: Position2D, _ direction: Position2D, _ grid: Grid2D) -> Int {
		let positions = positionsInDirection(pos, direction, grid)
		guard let last = positions.first(where: { grid.value($0) >= grid.value(pos) }) else {
			return positions.count
		}
		return pos.cityDistance(last)
	}
	
	func scenicScore(_ pos: Position2D, _ grid: Grid2D) -> Int {
		return cardinalDirections.reduce(1) { $0 * numVisible(pos, $1, grid ) }
	}

	func solveB(_ fileName: String) -> Int {
		let grid = Grid2D(fileName: fileName)
		return grid.allPositions.map { scenicScore($0, grid) }.max()!
	}
}
