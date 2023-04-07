import Foundation

public struct Stack {
  private var list = [String]()
  
  func isEmpty() -> Bool {
    return self.list.isEmpty
  }
  
  func count() -> Int {
    return self.list.count
  }
  
  func top() -> String? {
    return self.list.last
  }
  
  mutating func push(item: String) {
    self.list.append(item)
  }
  
  mutating func pop() {
    self.list.popLast()
  }
}
