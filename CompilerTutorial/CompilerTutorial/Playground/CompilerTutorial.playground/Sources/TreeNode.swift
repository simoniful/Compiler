import Foundation

class TreeNode {
  var tokens: ContextToken
  var children = [TreeNode]()
  var parent: TreeNode!
  var degree : Int
  
  init (tokens: ContextToken, degree: Int) {
    self.tokens = tokens
    self.degree = degree
  }
  
  func add(child: TreeNode) {
    children.append(child)
    child.parent = self
  }
}
