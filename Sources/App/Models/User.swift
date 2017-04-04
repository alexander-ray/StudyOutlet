// Code inspired by ray wenderlich's "registering users over ssl"
import Vapor
import Fluent
import Foundation
// Registration and authentication
import Turnstile
import TurnstileCrypto

struct User: Model {
    // Declarations
    var id: Node?
    var username: Valid<NameValidator>
    let password: String
    
    // For fluent
    var exists: Bool = false
    
    // Initializer
    init(username: String, rawPassword: String) throws {
        self.username = try username.validated()
        let validatedPassword: Valid<PasswordValidator> = try rawPassword.validated()
        self.password = BCrypt.hash(password: validatedPassword.value)
    }
    
    // Get from database
    init(node: Node, in context: Context) throws{
        id = try node.extract("id")
        let usernameString = try node.extract("username") as String
        username = try usernameString.validated()
        let passwordString = try node.extract("password") as String
        password = passwordString
    }
    
    // Insert into database
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "username": username.value,
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
    static func register(name: String, email: String, rawPassword: String) throws -> User {
        var newUser = try User(username: name, rawPassword: rawPassword) // Get information
        
        // Check if username already used
        if try User.query().filter("username", newUser.username.value).first() == nil {
            try newUser.save()
            return newUser
        } else {
            throw AccountTakenError()
        }
    }
}

import Auth

extension User: Auth.User {
    static func authenticate(credentials: Credentials) throws -> Auth.User {
        let user: User?
        
        switch credentials {
            case let id as Identifier:
                user = try User.find(id.id)
            case let accessToken as AccessToken:
                user = try User.query().filter("access_token", accessToken.string).first()
            case let apiKey as APIKey:
                user = try User.query().filter("email", apiKey.id).filter("password", apiKey.secret).first()
            default:
                throw Abort.custom(status: .badRequest, message: "Invalid credentials.")
        }
        
        guard let u = user else {
            throw Abort.custom(status: .badRequest, message: "User not found")
        }
        
        return u
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
