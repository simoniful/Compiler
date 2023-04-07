import Foundation

func output(tree: TreeNode) {
  var str: String = ""
  
  for _ in 0...tree.degree {
    str = str + "\t"
  }
  if tree.tokens.type == "LBracket" {
    str = str + "{ type: 'array', child: ["
  } else if tree.tokens.type == "RBracket" {
    str = str + "]"
  } else  {
    str = str + "{ type: '\(tree.tokens.type)', value: '\(tree.tokens.value)' },"
  }
  
  print(str)
}

func recursive(tree: TreeNode) {
  for element in tree.children{
    output(tree: element)
    if !element.children.isEmpty {
      recursive(tree: element)
    }
  }
}
