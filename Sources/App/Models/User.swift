import Vapor
import Fluent
import Foundation

struct User: Model {
    // Declarations
    var id: Node?
    let username: String
    let password: String
    
    // For fluent
    var exists: Bool = false
    // Initializer
    init(username: String, password: String){
        self.username = username
        self.password = password
    }
    
    // Get from database
    init(node: Node, in context: Context) throws{
        id = try node.extract("id")
        username = try node.extract("username")
        password = try node.extract("password")
    }
    
    // Insert into database
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "username": username,
            "password": password
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
}

