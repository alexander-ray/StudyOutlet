// Code by ray wenderlich
import Vapor

class PasswordValidator: ValidationSuite {
  static func validate(input value: String) throws {
    let range = value.range(of: "^(?=.*[0-9])(?=.*[A-Z])", options: .regularExpression) //set valid password range with regular expression
      throw error(with: value)
    }
}
