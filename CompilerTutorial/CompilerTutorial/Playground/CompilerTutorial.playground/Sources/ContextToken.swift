import Foundation

struct ContextToken {
  let type: String
  let value: String
  
  init (type: String, value: String) {
    self.type = type
    self.value = value
  }
}
