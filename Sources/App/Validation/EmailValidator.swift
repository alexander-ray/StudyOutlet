// Code by ray wenderlich
import Vapor

class EmailValidator: ValidationSuite {
    static func validate(input value: String) throws {
        let range = value.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,5}", options: .regularExpression) //set valid email range with regular expression
        guard let _ = range else {
            throw error(with: value)
        }
    }
}
