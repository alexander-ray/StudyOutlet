<<<<<<< HEAD
import Vapor
import Fluent
import Foundation

struct User: Model {
	

	//type initialization for User's members	
	var id: Node?
	let username: String
	let password: String

	
	//constructor setting username and password for a user as parameters
	init(username: String, password String){
		self.username = username
		self.password = password
	}

	//function that pulls info from database
	init(node: Node, in context: Context) throws{
		//use "try" in case info not available
		id = try node.extract("id")
		username = try node.extract("username")
		password = try node.extract("password")
	}
	
	//Inserting into database
	//Fairly certain it's called when new user created
	func makeNode(context: Context) throws -> Node {
		return try Node(node: [
			"id": id,
			"username": username,
			"password": password
		])
	}
	
	//in case there is no table already present
	static fun prepare(_ databse: Database) throws {
		try database.create("users") { users in
			users.id()
			users.string("username")
			users.string("password")
		}
	}
	//Deletes a table if needed
	static func revert(_ database: Database) throws{
		try database.delete("users")
	}
}

extension User {
	static func dataToString(_ data: Data) -> String {
		return String(data: data, encoding: String.Encoding.utf8)!
	}
	static fun stringToData(_ dataString: String) -> Data {
		return dataString.data(using: .utf8)!
	}
=======
// Authentication code largely from ray wenderlich's "registering users over ssl" and "Authentication with Turnstile
// Model/auth code from https://vapor.github.io/documentation/
import Vapor
import Fluent
import Foundation
// Registration and authentication
import Turnstile
import TurnstileCrypto
import TurnstileWeb
import HTTP

struct User: Model {
    // Declarations
    var id: Node?
    var email = ""
    //var username: String
    var password = ""
    var accessKey: String
    //var apiKeyID = URandom().secureToken
    //var apiKeySecret = URandom().secureToken
    
    // For fluent
    var exists: Bool = false
    
    // Initializer
    init(credentials: UsernamePassword) throws {
        //self.username = credentials.username
        let validatedEmail: Valid<EmailValidator> = try credentials.username.validated()
        self.email = validatedEmail.value
        
        let validatedPassword: Valid<PasswordValidator> = try credentials.password.validated()
        self.password = BCrypt.hash(password: validatedPassword.value)
        
        self.accessKey = URandom().secureToken // Create token randomly
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        //username = try node.extract("username")
        email = try node.extract("email")
        password = try node.extract("password")
        accessKey = try node.extract("access_key")
    }
    
    // Insert into database
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            //"username": username,
            "email": email,
            "password": password,
            "access_key": accessKey,
            ])
    }
    
    static func getAccessKey(email: String) throws -> String {
        var user: User?
        user = try User.query().filter("email", email).first() // Try to find username in database
        return (user?.accessKey)!
    }
    
    // Database setup functions
    static func prepare(_ database: Database) throws {
        try database.create("users") { users in
            users.id()
            users.string("email")
            users.string("password")
            users.string("access_key")
        }
    }
    static func revert(_ database: Database) throws{
        try database.delete("users")
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
                    .filter("email", credentials.username).first()
                // If password is not empty and hashes match
                if let password = fetchedUser?.password,
                    password != "",
                    (try? BCrypt.verify(password: credentials.password, matchesHash: password)) == true {
                    user = fetchedUser
                }
            // Used for session authentication
            case let credentials as Identifier:
                user = try User.find(credentials.id)
            // Access token checking
            case let accessToken as AccessToken:
                user = try User.query().filter("access_key", accessToken.string).first()
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
    
    // Registering new user
    static func register(credentials: Credentials) throws -> Auth.User {
        var newUser: User
        switch credentials {
        case let credentials as UsernamePassword:
            newUser = try User(credentials: credentials)
        default:
            throw UnsupportedCredentialsError()
        }
        
        // Check if username not already used
        if try User.query().filter("email", newUser.email).first() == nil {
            try newUser.save()
            return newUser
        } else {
            throw AccountTakenError()
        }
    }
>>>>>>> 44ca9723d5870bd69a9b3f9b2530ac43fe2505f3
}
