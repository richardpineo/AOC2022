
import AOCLib
import Foundation

class Solve13: PuzzleSolver {
	func solveAExamples() -> Bool {
		solveA("Example13") == 13
	}

	func solveBExamples() -> Bool {
		return solveB("Example13") == 0
	}

	var answerA = ""
	var answerB = ""

	func solveA() -> String {
		solveA("Input13").description
	}

	func solveB() -> String {
		solveB("Input13").description
	}

	enum Packet {
		case integer(Int)
		case list([Packet])
		
		var debugDisplay: String {
			switch self {
			case let .integer(value):
				return value.description
			case let .list(packets):
				var s = "["
				for index in 0 ..< packets.count {
					s += packets[index].debugDisplay
					if index != packets.count - 1 {
						s += ","
					}
				}
				s += "]"
				return s
			}
		}
		
		func compare(_ other: Packet) -> Int {
			switch (self, other) {
			case let (.integer(left), .integer(right)):
				if left == right {
					return 0
				}
				return left < right ? 1 : -1
			case let (.list(left), .list(right)):
				for index in 0 ..< min(left.count, right.count) {
					let comp = left[index].compare(right[index])
					if comp != 0 {
						return comp
					}
				}
				if left.count == right.count {
					return 0
				}
				return left.count < right.count ? 1 : -1
				
			case let (.integer(left), .list(_)):
				return Packet.list([.integer(left)]).compare(other)

			case let (.list(_), .integer(right)):
				return compare(Packet.list( [.integer(right)]))
			}
		}
	}
	
	struct PacketPair {
		let left: Packet
		let right: Packet
		var debugDisplay: String {
			"\(left.debugDisplay)\n\(right.debugDisplay)"
		}
		
		var compare: Int {
			return left.compare(right)
		}
	}
		
	func parsePacket(_ s: String, pos: inout Int) -> Packet {
		switch s.character(at: pos) {
		case "[":
			var contents: [Packet] = []
			pos += 1
			while pos < s.count {
				switch s.character(at: pos) {
				case "]":
					pos += 1
					return .list(contents)
				case ",":
					pos += 1
					contents.append(parsePacket(s, pos: &pos))
				default:
					contents.append(parsePacket(s, pos: &pos))
				}
			}
			return .list(contents)

			
		case "]":
			pos += 1
			return .list([])
			
		case "0" ... "9":
			let subStr = s.subString(start: pos, count: s.count - pos)
			let end = subStr.firstIndex { !$0.isNumber }
			let endIndex: Int = s.distance(from: subStr.startIndex, to: end!)
			
			let value = Int(s.subString(start: pos, count: endIndex ))!
			pos = pos + endIndex
			return .integer(value)
			
		default:
			break
		}
		exit(1)
	}
	
	func loadPairs(_ fileName: String) -> [PacketPair] {
		let lines = FileHelper.load(fileName)!
		var pairs: [PacketPair] = []
		for lineIndex in stride(from: 0, to: lines.count, by: 3) {
			var posA = 0
			let left = parsePacket(lines[lineIndex], pos: &posA)
			var posB = 0
			let right = parsePacket(lines[lineIndex + 1], pos: &posB)
			
			if lines[lineIndex] != left.debugDisplay ||
				lines[lineIndex + 1] != right.debugDisplay {
				print("Input:\n  \(lines[lineIndex])\n  \(lines[lineIndex+1])")
				print("Parsed:\n  \(left.debugDisplay)\n  \(right.debugDisplay)")
				exit(1)
			}
			pairs.append(.init(left: left, right: right))
		}
		return pairs
	}
	
	func solveA(_ fileName: String) -> Int {
		let pairs = loadPairs(fileName)
		var sum = 0
		for index in 1 ... pairs.count {
			if pairs[index - 1].compare  == 1 {
				sum += index
			}
		}
		return sum
	}

	func solveB(_ fileName: String) -> Int {
		0
	}
}
