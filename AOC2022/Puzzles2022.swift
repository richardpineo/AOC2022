
import AOCLib
import SwiftUI

class Puzzles2022: PuzzlesRepo {
	init() {
		let year = 2022

		puzzles = Puzzles(puzzles: [
			Puzzle(year: year, id: 1, name: "Calorie Counting") { Solve1() },
			Puzzle(year: year, id: 2, name: "Rock Paper Scissors") { Solve2() },
			Puzzle(year: year, id: 3, name: "Rucksack Reorganization") { Solve3() },
			Puzzle(year: year, id: 4, name: "Camp Cleanup") { Solve4() },
			Puzzle(year: year, id: 5, name: "Supply Stacks") { Solve5() },
			Puzzle(year: year, id: 6, name: "Tuning Trouble") { Solve6() },
			Puzzle(year: year, id: 7, name: "No Space Left On Device") { Solve7() },
			Puzzle(year: year, id: 8, name: "Treetop Tree House") { Solve8() },
			Puzzle(year: year, id: 9, name: "Rope Bridge") { Solve9() },
			Puzzle(year: year, id: 10, name: "Cathode-Ray Tube") { Solve10() },
			Puzzle(year: year, id: 11, name: "Monkey in the Middle") { Solve11() },
			Puzzle(year: year, id: 12, name: "Hill Climbing Algorithm") { Solve12() },
			Puzzle(year: year, id: 13, name: "Distress Signal") { Solve13() },
			Puzzle(year: year, id: 14, name: "Regolith Reservoir") { Solve14() },
			Puzzle(year: year, id: 15, name: "Beacon Exclusion Zone") { Solve15() },
			Puzzle(year: year, id: 16, name: "Proboscidea Volcanium") { Solve16() },
			Puzzle(year: year, id: 17, name: "Pyroclastic Flow") { Solve17() },
			Puzzle(year: year, id: 18, name: "Boiling Boulders") { Solve18() },

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
