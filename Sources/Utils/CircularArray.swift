struct CircularArray<T> {
    private var array: [T]
    private var currentIndex: Int
    
    init(_ array: [T]) {
        self.array = array
        self.currentIndex = 0
    }
    
    mutating func next() -> T {
        let element = array[currentIndex]
        currentIndex = (currentIndex + 1) % array.count
        return element
    }
}