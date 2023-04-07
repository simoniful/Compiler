import Foundation

extension String{
  func hasNumbers() -> Bool{
    do {
      let regex = try NSRegularExpression(
        pattern: "^[0-9]+",
        options: .caseInsensitive
      )
      if let _ = regex.firstMatch(
        in: self,
        options: NSRegularExpression.MatchingOptions.reportCompletion,
        range: NSMakeRange(0, self.count)
      ) {
        return true
      }
    } catch {
      print(error.localizedDescription)
      return false
    }
    return false
  }
}
