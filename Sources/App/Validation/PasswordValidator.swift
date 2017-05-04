// Code largely from ray wenderlich
import Vapor

// Checking that password includes the necessary components
class PasswordValidator: ValidationSuite {  
    static func validate(input value: String) throws {
        // Password must include at least one uppercase letter and at least one number
        let range = value.range(of: "^(?=.*[0-9])(?=.*[A-Z])", options: .regularExpression)
            throw error(with: value)
    }
}
