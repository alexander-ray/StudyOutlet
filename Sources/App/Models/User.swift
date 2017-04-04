// Authentication code largely from ray wenderlich's "registering users over ssl" and "Authentication with Turnstile
// Model/auth code from https://vapor.github.io/documentation/
import Vapor
import Fluent
import Foundation
// Registration and authentication
import Turnstile
import TurnstileCrypto

struct User: Model {
    // Declarations
    var id: Node?
    var username: String
    let password: String
    
    // For fluent
    var exists: Bool = false
    
    // Initializer
    init(username: String, rawPassword: String) throws {
        self.username = username
        let validatedPassword: Valid<PasswordValidator> = try rawPassword.validated()
        self.password = BCrypt.hash(password: validatedPassword.value)
    }
    
    // Get from database
    init(node: Node, in context: Context) throws{
        id = try node.extract("id")
        username = try node.extract("username")
        let passwordString = try node.extract("password") as String
        password = passwordString
    }
    
    // Insert into database
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "username": username,
            "password": password,
        ])
    }
    
    // Database setup functions
    static func prepare(_ database: Database) throws {
        try database.create("users") { users in
            users.id()
            users.string("username")
            users.string("password")
        }
    }
    static func revert(_ database: Database) throws{
        try database.delete("users")
    }
    
    // Registering new user
    static func register(username: String, rawPassword: String) throws -> User {
        var newUser = try User(username: name, rawPassword: rawPassword) // Get information
        
        // Check if username already used
        if try User.query().filter("username", newUser.username).first() == nil {
            try newUser.save()
            return newUser
        } else {
            throw AccountTakenError()
        }
    }
}

import Auth

extension User: Auth.User {
    // Authenticate given credentials
    static func authenticate(credentials: Credentials) throws -> Auth.User {
        var user: User?
        
        switch credentials {
            // Can add cases for different types of authentication
            case let credentials as UsernamePassword:
                // Try to find user, filtering by username
                let fetchedUser = try User.query()
                    .filter("username", credentials.username)
                    .first()
                // If password is not empty and hashes match
                if let password = fetchedUser?.password,
                    password != "",
                    (try? BCrypt.verify(password: credentials.password, matchesHash: password)) == true {
                    user = fetchedUser
                }
            // Used for session authentication
            case let credentials as Identifier:
                user = try User.find(credentials.id)
            default:
                throw UnsupportedCredentialsError()
        }
        
        // If user exists, return
        // Else, throw error
        if let user = user {
            return user
        }
        else {
            throw IncorrectCredentialsError()
        }
    }
    
    
    static func register(credentials: Credentials) throws -> Auth.User {
        throw Abort.custom(status: .badRequest, message: "Register not supported.")
    }
}

import HTTP

extension Request {
    func user() throws -> User {
        guard let user = try auth.user() as? User else {
            throw Abort.custom(status: .badRequest, message: "Invalid user type.")
        }
        
        return user
    }
}
