
import AOCLib
import Foundation

class Solve7: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example7") == 95437
	}

	func solveBExamples() -> Bool {
		false
	}

	var answerA = "1334506"
	var answerB = ""
	
	class FileSystem {
		struct File {
			var name: String
			var size: Int
		}
		
		class Directory {
			init(name: String, parent: Directory?) {
				self.name = name
				self.parent = parent
			}
			
			var name: String
			var parent: Directory?
			var directories: [Directory] = []
			var files: [File] = []
			
			func subdir(_ name: String) -> Directory {
				directories.first { $0.name == name }!
			}
			
			var size: Int {
				return directories.map(\.size).reduce(0, +) + files.map(\.size).reduce(0, +)
			}
		}
		
		var root: Directory = .init(name: "/", parent: nil)
	}
	
	func enumerateSubdirs(_ dir: FileSystem.Directory) -> [FileSystem.Directory] {
		var subDirs: [FileSystem.Directory] = [dir]
		dir.directories.forEach {
			subDirs.append(contentsOf: enumerateSubdirs($0))
		}
		return subDirs
	}

	func solveA() -> String {
		solveA("Input7").description
	}

	func solveB() -> String {
		""
	}

	func solveA(_ fileName: String) -> Int {
		let fs = load(fileName)
		let directories = enumerateSubdirs(fs.root)
		return directories.map(\.size).filter { $0 <= 100000 }.reduce(0, +)
	}
	
	func load(_ fileName: String) -> FileSystem {
		let lines = FileHelper.loadAndTokenize(fileName)
		let fs = FileSystem()
		var cwd = fs.root
		lines.forEach { line in
			if line.count == 0 {
				return
			}
			switch line[0] {
			case "$":
				switch line[1] {
					case "cd":
					switch line [2] {
					case "/":
						cwd = fs.root
					case "..":
						cwd = cwd.parent ?? fs.root
					default:
						cwd = cwd.subdir(line[2])
					}
					case "ls":
					// do nothing
					break
				default:
					return
				}
				
			case "dir":
				cwd.directories.append(.init(name: line[1], parent: cwd))
				
			default: // must be a file
				cwd.files.append(.init(name: line[1], size: Int(line[0])!))
				return
			}
		}
		return fs
	}
}
