# swift-algorithms
Algorithms and data structures

<details>
<summary>Stack</summary>
  
# [Stack](https://github.com/AsahiOcean/swift-algorithms/tree/main/Stack)

#### Stack – abstract data type that is a list of elements organized accord to the LIFO principle ("last in - first out").

### There are two main operations on the stack:

```
Push: which adds an element to the collection
```
```
Pop: removes the most recently added element
```

[![stack.png](https://i.postimg.cc/jdzkdHjX/stack.png)](https://postimg.cc/Tp3ctWgL)

A stack is like an array but with limited functionality. You can only push to add a new element to the top of the stack, pop to remove the element from the top, and peek at the top element without popping it off.

Why would you want to do this? Well, in many algorithms you want to add objects to a temporary list at some point and then pull them off this list again at a later time. Often the order in which you add and remove these objects matters.

A stack gives you a LIFO or last-in first-out order. The element you pushed last is the first one to come off with the next pop. (A very similar data structure, the queue, is FIFO or first-in first-out.)

Notice that a push puts the new element at the end of the array, not the beginning. Inserting at the beginning of an array is expensive, an O(n) operation, because it requires all existing array elements to be shifted in memory. Adding at the end is O(1); it always takes the same amount of time, regardless of the size of the array.

Fun fact about stacks: Each time you call a function or a method, the CPU places the return address on a stack. When the function ends, the CPU uses that return address to jump back to the caller. That's why if you call too many functions -- for example in a recursive function that never ends -- you get a so-called "stack overflow" as the CPU stack has run out of space.
</details>

<details>
  <summary>Queue</summary>

  # [Queue](https://github.com/AsahiOcean/swift-algorithms/tree/main/Queue)

A queue is a list where you can only insert new items at the back and remove items from the front. This ensures that the first item you enqueue is also the first item you dequeue. Queue works according to the principle "first come – first serve"

Why would you need this? Well, in many algorithms you want to add objects to a temporary list and pull them off this list later. Often the order in which you add and remove these objects matters.

A queue gives you a FIFO or first-in, first-out order. The element you inserted first is the first one to come out. (A similar data structure: stack is a LIFO or "last-in first-out")

Here is an example to enqueue a number:
```
queue.enqueue(10)
```
The queue is now [ 10 ].

Add the next number to the queue:
```
queue.enqueue(3)
```
The queue is now [ 10, 3 ].

Add one more number:
```
queue.enqueue(57)
```
The queue is now [ 10, 3, 57 ].

Let's dequeue to pull the first element off the front of the queue:
```
queue.dequeue()
```

This returns 10 because that was the first number we inserted.

The queue is now [ 3, 57 ]. Everyone moved up by one place.
```
queue.dequeue()
```

This returns 3, the next dequeue returns 57, and so on.
If the queue is empty, dequeuing returns nil or in some implementations it gives an error message.

**Note:** A queue is not always the best choice. If the order in which the items are added and removed from the list is not important, you can use a stack instead of a queue. Stacks are simpler and faster.

### The code

Here is a simplistic implementation of a queue in Swift. It is a wrapper around an array to enqueue, dequeue, and peek at the front-most item:

```
struct Queue<T> {
    fileprivate var array = [T]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    var front: T? {
        return array.first
    }
}
```

This queue works well, but it is not op👽al.

Enqueuing is an O(1) operation because adding to the end of an array always takes the same amount of 👽e regardless of the size of the array.

You might be wondering why appending items to an array is O(1) or a constant-👽e operation. That is because an array in Swift always has some empty space at the end. If we do the following:

```
var queue = Queue<String>()
queue.enqueue("🦖")
queue.enqueue("👻")
queue.enqueue("👽")
```

Then the array might actually look like this:
```
[ "🦖", "👻", "👽", xxx, xxx, xxx ]
```

where **xxx** is memory that is reserved but not filled in yet. Adding a new element to the array overwrites the next unused spot:
```
[ "🦖", "👻", "👽", "👾", xxx, xxx ]
```

This results by copying memory from one place to another which is a constant-👽e operation.

There are only a limited number of unused spots at the end of the array. When the last **xxx** gets used, and you want to add another item, the array needs to resize to make more room.

Resizing includes allocating new memory and copying all the existing data over to the new array. This is an **O(n)** process which is relatively slow. Since it happens occasionally, the 👽e for appending a new element to the end of the array is still **O(1)** on average or **O(1)** "amortized".

The story for dequeueing is different. To dequeue, we remove the element from the beginning of the array. This is always an **O(n)** operation because it requires all remaining array elements to be shifted in memory.

In our example, dequeuing the first element **"🦖"** copies **"👻"** in the place of **"🦖"**, **"👽"** in the place of **"👻"**, and **"👾"** in the place of **"👽"**:

```
before   [ "🦖", "👻", "👽", "👾", xxx, xxx ]
                 /     /     /
                /     /     /
               /     /     /
              /     /     /
 after   [ "👻", "👽", "👾", xxx, xxx, xxx ]
 ```
 
Moving all these elements in memory is always an **O(n)** operation. So with our simple implementation of a queue, enqueuing is efficient, but dequeueing leaves something to be desired...

### A more efficient queue

To make dequeuing efficient, we can also reserve some extra free space but this 👽e at the front of the array. We must write this code ourselves because the built-in Swift array does not support it.

The main idea is whenever we dequeue an item, we do not shift the contents of the array to the front (slow) but mark the item's position in the array as empty (fast). After dequeuing **"🦖"**, the array is:

```
[ xxx, "👻", "👽", "👾", xxx, xxx ]
```

After dequeuing **"👻"**, the array is:
```
[ xxx, xxx, "👽", "👾", xxx, xxx ]
```

Because these empty spots at the front never get reused, you can periodically trim the array by moving the remaining elements to the front:
```
[ "👽", "👾", xxx, xxx, xxx, xxx ]
```

This trimming procedure involves shifting memory which is an **O(n)** operation. Because this only happens once in a while, dequeuing is **O(1)** on average.

Here is how you can implement this version of **Queue**:
```
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
    }
    
    mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return nil }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
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
```

The array now stores objects of type **T?** instead of just **T** because we need to mark array elements as being empty. The **head** variable is the index in the array of the front-most object.

Most of the new functionality sits in **dequeue()**. When we dequeue an item, we first set **array[head]** to **nil** to remove the object from the array. Then, we increment **head** because the next item has become the front one.

We go from this:
```
[ "🦖", "👻", "👽", "👾", xxx, xxx ]
  head
```

to this:
```
[ xxx, "👻", "👽", "👾", xxx, xxx ]
       head
```

It is like if in a supermarket the people in the checkout lane do not shuffle forward towards the cash register, but the cash register moves up the queue.

If we never remove those empty spots at the front then the array will keep growing as we enqueue and dequeue elements. To periodically trim down the array, we do the following:

```
let percentage = Double(head)/Double(array.count)
if array.count > 50 && percentage > 0.25 {
    array.removeFirst(head)
    head = 0
}
```

This calculates the percentage of empty spots at the beginning as a ratio of the total array size. If more than 25% of the array is unused, we chop off that wasted space. However, if the array is small we do not resize it all the 👽e, so there must be at least 50 elements in the array before we try to trim it.

Note: I just pulled these numbers out of thin air -- you may need to tweak them based on the behavior of your app in a production environment.

To test this in a playground, do the following:
```
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
```

To test the trimming behavior, replace the line,
```
if array.count > 50 && percentage > 0.25 {
```

with:
```
if head > 2 {
```

Now if you dequeue another object, the array will look as follows:
```
q.dequeue()         // "👽"
q.array             // [{Some "👾"}]
q.count             // 1
```

The **nil** objects at the front have been removed, and the array is no longer wasting space. This new version of **Queue** is not more complicated than the first one but dequeuing is now also an O(1) operation, just because we were aware about how we used the array.

Written for Swift Algorithm Club by Matthijs Hollemans
</details>
