import Foundation

class Validator {
  enum ArrayError: Error {
    case invalidValue
  }
  
  func isArray(str: String) throws -> Bool {
    var stack: Stack = Stack()
    
    for element in str {
      if !stack.isEmpty() && stack.top() == "[" && element == "]" {
        stack.pop()
      } else if element == "]" || element == "[" {
        stack.push(item: String(element))
      }
    }
    
    if stack.count() == 0 {
      return true
    } else {
      throw ArrayError.invalidValue
    }
  }
  
  func isSeperator(letter: Character) -> Bool {
    return letter == "[" || letter == "]" || letter == ","
  }
  
  func isQuote(letter: Character) -> Bool {
    return letter == "\'" || letter == "\""
  }
  
  func isString(quoteArray: [Character]) -> Bool {
    return quoteArray.count == 0
  }
}
