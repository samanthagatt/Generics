struct CountedSet<Element>: ExpressibleByArrayLiteral, Sequence, IteratorProtocol, Equatable where Element: Hashable {
    
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
    
    func contains(_ element: Element) -> Bool {
        guard let _ = storage[element] else { return false }
        return true
    }
    
    mutating func mutatingUnion(_ countedSet: CountedSet<Element>) {
        for element in countedSet {
            insert(element)
        }
    }
    
    func union(_ countedSet: CountedSet<Element>) -> CountedSet<Element> {
        var newCountedSet = CountedSet()
        newCountedSet.storage = storage
        for element in countedSet {
            newCountedSet.insert(element)
        }
        return newCountedSet
    }
    
    func intersection(_ countedSet: CountedSet<Element>) -> CountedSet<Element> {
        var newCountedSet: CountedSet<Element> = []
        for element in countedSet {
            guard self.contains(element) else { continue }
            newCountedSet.insert(element)
        }
        return newCountedSet
    }
    
    func subtraction(_ countedSet: CountedSet<Element>) -> CountedSet<Element> {
        var newCountedSet: CountedSet<Element> = []
        for element in self {
            guard !self.contains(element) else { continue }
            newCountedSet.insert(element)
        }
        return newCountedSet
    }
    
    static func == (lhs: CountedSet<Element>, rhs: CountedSet<Element>) -> Bool {
        return lhs.storage == rhs.storage
    }
    
    func isDisjointed() -> Bool {
        var new: CountedSet<Element> = []
        for element in self {
            new.insert(element)
        }
        if self == new {
            return false
        } else {
            return true
        }
    }
    
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

var secondCountedSet: CountedSet<Arrow> = [.iron, .dwarvish, .magic]

let unionedCountedSet = myCountedSet.union(secondCountedSet)
unionedCountedSet[.iron]
unionedCountedSet[.dwarvish]
unionedCountedSet[.magic]

secondCountedSet.mutatingUnion(myCountedSet)
secondCountedSet[.silver]
secondCountedSet.count

let one: CountedSet<Arrow> = [.iron, .wooden, .elven, .iron]
one[.iron]
let two: CountedSet<Arrow> = [.iron, .silver, .iron, .iron]

let intersected = one.intersection(two)
intersected[.iron]
let oneSubtracted = two.subtraction(one)
oneSubtracted[.iron]

let oneDuplicated: CountedSet<Arrow> = [.iron, .wooden, .elven, .iron]
one == oneDuplicated
one == two
