
public struct Queue<T> {
	
	fileprivate var list = LinkedList<T>()
	fileprivate var count:Int = 0
	
	public var isEmpty: Bool {
		return list.isEmpty
	}
	
	public mutating func enqueue(_ element: T) {
		list.append(value: element)
		count = count + 1
	}

	public mutating func dequeue() -> T? {
		guard !list.isEmpty, let element = list.first else { return nil }
		_ = list.remove(node: element)
		count = count - 1
		return element.value
	}
	
	public func getLength() -> Int {
		return count
	}

	public func peek() -> T? {
		return list.first?.value
	}
}
