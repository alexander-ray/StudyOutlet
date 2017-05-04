// Code largely from  ray wenderlich
import Vapor

// For checking email during registration/login
class EmailValidator: ValidationSuite {
    static func validate(input value: String) throws {
        // Regex from woosung
        let range = value.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .regularExpression) //set valid email range with regular expression
        guard let _ = range else {
            throw error(with: value)
        }
    }
}
