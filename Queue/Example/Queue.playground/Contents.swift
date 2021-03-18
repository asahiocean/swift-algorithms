import Foundation

struct Queue<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    var isEmpty: Bool {
        return count == 0
    }
    
    var count: Int {
        return array.count - head
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
        print("enqueue", array)
    }
    
    mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        /*
         If we never remove those empty spots at the front then the array will
         keep growing as we enqueue and dequeue elements.
         To periodically trim down the array, we do the following:
         */
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            /*
             This calculates the percentage of empty spots at the beginning
             as a ratio of the total array size. If more than 25% of the array is unused,
             we chop off that wasted space. However, if the array is small we do not resize it all
             the time, so there must be at least 50 elements in the array before we try to trim it.
             */
            array.removeFirst(head)
            head = 0
        }
        print("dequeue", array)
        return element
    }
    
    var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}
var q = Queue<String>()
q.array             // [] empty array

q.enqueue("🦖")
q.enqueue("👻")
q.enqueue("👽")
q.array             // [{Some "🦖"}, {Some "👻"}, {Some "👽"}]
q.count             // 3

q.dequeue()         // "🦖"
q.array             // [nil, {Some "👻"}, {Some "👽"}]
q.count             // 2

q.dequeue()         // "👻"
q.array             // [nil, nil, {Some "👽"}]
q.count             // 1

q.enqueue("👾")
q.array             // [nil, nil, {Some "👽"}, {Some "👾"}]
q.count             // 2
