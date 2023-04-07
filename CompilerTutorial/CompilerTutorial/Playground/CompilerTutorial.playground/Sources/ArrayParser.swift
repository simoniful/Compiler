import Foundation

public struct ArrayParser {
  var quoteArray = [Character]()
  let validator = Validator()
  
  public init(str: String) {
    print(self.parser(str: str))
  }
  
  mutating func pushQuoteArray(letter: Character) {
    if self.quoteArray.count == 0 {
      self.quoteArray.append(letter)
    } else {
      if self.quoteArray[0] == letter {
        self.quoteArray.popLast()
      }
    }
  }
  
  mutating func tokenizer(str: String) -> [String] {
    do{
      try !validator.isArray(str: str)
      var tokenArray = [String]()
      var tokenStack = [String]()
      
      for element in str {
        if validator.isQuote(letter: element) {
          self.pushQuoteArray(letter: element)
        }
        if validator.isSeperator(letter: element) && validator.isString(quoteArray: quoteArray) {
          let token = tokenStack
            .joined(separator: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
          
          tokenStack = [String]();
          if token != "" {
            tokenArray.append(String(token))
          }
          tokenArray.append(String(element))
          continue
        }
        tokenStack.append(String(element))
      }
      
      return tokenArray
      
    }
    catch {
      print("올바른 배열 형태가 아니네요")
      exit(0)
    }
  }
  
  func makeContextToken(token: String) -> ContextToken {
    return ContextToken(
      type: self.checkTokenType(token: token),
      value: token
    )
  }
  
  func checkTokenType(token: String) -> String {
    var tokenType = ""
    
    switch token {
    case "[":
      tokenType = "LBracket"
    case "]":
      tokenType = "RBracket"
    case "null":
      tokenType = "NULL"
    case ",":
      tokenType = "comma"
    default:
      if token.hasNumbers() {
        tokenType = "number"
      } else {
        tokenType = "String"
      }
    }
    return tokenType
  }
  
  func lexer(tokenArray: [String]) -> [ContextToken] {
    var contextTokenArray = [ContextToken]()
    
    for token in tokenArray {
      let contextToken = self.makeContextToken(token: token)
      contextTokenArray.append(contextToken)
    }
    return contextTokenArray
  }
  
  mutating func parser(str: String)  {
    let lexerArray = self.lexer(tokenArray: self.tokenizer(str: str))
    let endIdnex = lexerArray.endIndex - 1
    let startIdnex = lexerArray.startIndex
    var degree: Int = 0
    var tree = TreeNode(tokens: lexerArray[0], degree: degree)
    
    for (index, element) in lexerArray.enumerated() {
      if index != startIdnex && index != endIdnex {
        if element.type == "LBracket" {
          tree.add(child: TreeNode(tokens: element, degree: degree))
          tree = tree.children[tree.children.endIndex - 1]
          degree = degree + 1
        } else if element.type == "RBracket" {
          tree = tree.parent
          degree = degree-1
          tree.add(child: TreeNode(tokens: element, degree: degree))
        } else if element.type != "comma" {
          tree.add(child: TreeNode(tokens: element, degree: degree))
        }
      }
    }
    
    print("[")
    for element in tree.children{
      output(tree: element)
      if !element.children.isEmpty {
        recursive(tree: element)
      }
    }
    print("]")
  }
}
