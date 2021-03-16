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
