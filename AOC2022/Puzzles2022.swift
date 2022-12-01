
import AOCLib
import SwiftUI

class Puzzles2022: PuzzlesRepo {
	init() {
		let year = 2022

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Sonar Sweep") { Solve1() },
		])
	}

	var title: String {
		"Advent of Code 2021"
	}

	var puzzles: Puzzles

	func hasDetails(id: Int) -> Bool {
		id == 9
	}

	@ViewBuilder
	func details(id: Int) -> some View {
		EmptyView()
	}
}
