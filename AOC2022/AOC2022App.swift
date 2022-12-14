
import AOCLib
import SwiftUI

@main
struct AOC2022App: App {
	let puzzles = Puzzles2022()
	var body: some Scene {
		WindowGroup {
			MainView(repo: puzzles)
				.environmentObject(PuzzleProcessing.application(puzzles: puzzles.puzzles))
		}
	}
}
