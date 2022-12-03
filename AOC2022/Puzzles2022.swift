
import AOCLib
import SwiftUI

class Puzzles2022: PuzzlesRepo {
	init() {
		let year = 2022

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Calorie Counting") { Solve1() },
			Puzzle(year: year, id: 2, name: "Rock Paper Scissors") { Solve2() },
			Puzzle(year: year, id: 3, name: "Rucksack Reorganization") { Solve3() },
		])
	}

	var title: String {
		"Advent of Code 2022"
	}

	var puzzles: Puzzles

	func hasDetails(id _: Int) -> Bool {
		false
	}

	@ViewBuilder
	func details(id _: Int) -> some View {
		EmptyView()
	}
}
