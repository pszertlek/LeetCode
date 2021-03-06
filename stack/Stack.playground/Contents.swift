
// last checked with Xcode 9.0b4
#if swift(>=4.0)
print("Hello, Swift 4!")
#endif

/*
  Stack

  A stack is like an array but with limited functionality. You can only push
  to add a new element to the top of the stack, pop to remove the element from
  the top, and peek at the top element without popping it off.

  A stack gives you a LIFO or last-in first-out order. The element you pushed
  last is the first one to come off with the next pop.

  Push and pop are O(1) operations.
*/

public struct Stack<T> {
  fileprivate var array = [T]()

  public var count: Int {
    return array.count
  }

  public var isEmpty: Bool {
    return array.isEmpty
  }

  public mutating func push(_ element: T) {
    array.append(element)
  }

  public mutating func pop() -> T? {
    return array.popLast()
  }

  public var top: T? {
    return array.last
  }
}

func ValidParentheses(_ s: String) -> Bool {
    var stack = Stack<Character>()
    for c in s {
        if c == "("{
            stack.push(c)
        } else if c == "[" {
            stack.push(c)
        } else if c == ")" {
            if stack.top == "(" {
                stack.pop()
            } else {
                return false
            }
        } else if c == "]" {
            if stack.top == "[" {
                stack.pop()
            } else {
                return false
            }
        } else if c == "{" {
            if stack.top == "{" {
                stack.push("{")
            } else {
                return false
            }
        } else if c == "}" {
            if stack.top == "}" {
                stack.pop()
            } else {
                return false
            }
        }
    }
    return stack.isEmpty
}

ValidParentheses("()[]{}")

// Create a stack and put some elements on it already.
var stackOfNames = Stack(array: ["Carl", "Lisa", "Stephanie", "Jeff", "Wade"])

// Add an element to the top of the stack.
stackOfNames.push("Mike")

// The stack is now ["Carl", "Lisa", "Stephanie", "Jeff", "Wade", "Mike"]
print(stackOfNames.array)

// Remove and return the first element from the stack. This returns "Mike".
stackOfNames.pop()

// Look at the first element from the stack.
// Returns "Wade" since "Mike" was popped on the previous line.
stackOfNames.top

// Check to see if the stack is empty.
// Returns "false" since the stack still has elements in it.
stackOfNames.isEmpty
