struct CountedSet<Element>: ExpressibleByArrayLiteral where Element: Hashable {
    
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
}

enum Arrow { case iron, wooden, elven, dwarvish, magic, silver }
var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0
