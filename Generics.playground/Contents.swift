struct CountedSet<Element>: ExpressibleByArrayLiteral, Sequence, IteratorProtocol where Element: Hashable {
    
    init(arrayLiteral: Element...) {
        for element in arrayLiteral {
            insert(element)
        }
    }
    
    private(set) var storage: [Element: Int] = [:]
    
    var count: Int {
        return storage.count
    }
    
    var isEmpty: Bool {
        if count == 0 {
            return true
        } else {
            return false
        }
    }
    
    subscript(_ element: Element) -> Int {
        get {
            return storage[element] ?? 0
        }
    }
    
    mutating func insert(_ element: Element) {
        guard let int = storage[element] else {
            storage[element] = 1
            return
        }
        storage[element] = int + 1
    }
    
    mutating func remove(_ element: Element) -> Int {
        guard let int = storage[element] else { return 0 }
        storage[element] = int - 1
        return storage[element] ?? 0
    }
    
    //    func contains(_ element: Element) -> Bool {
    //        guard let _ = storage[element] else { return false }
    //        return true
    //    }
    
    mutating func next() -> Element? {
        guard let element = storage.first else { return nil }
        defer { storage.remove(at: storage.startIndex) }
        return element.key
    }
}

enum Arrow { case iron, wooden, elven, dwarvish, magic, silver }
var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0
myCountedSet.isEmpty
myCountedSet.count

for element in myCountedSet {
    print(element)
}

if myCountedSet.contains(.dwarvish) && myCountedSet.contains(.iron) {
    print("myCountedSet contains both")
} else if myCountedSet.contains(.iron) {
    print("myCountedSet only contains .iron")
} else {
    print("myCountedSet doesn't conatin any")
}
