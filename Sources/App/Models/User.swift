import Vapor
import Fluent
import Foundation

struct User: Model {
	
	var id: Node?
	let username: String
	let password: String

	init(username: String, password String){
		self.username = username
		self.password = password
	}

	init(node: Node, in context: Context) throws{
		id = try node.extract("id")
		username = try node.extract("username")
		password = try node.extract("password")
	}

	func makeNode(context: Context) throws -> Node {
		return try Node(node: [
			"id": id,
			"username": username,
			"password": password
		])
	}
	
	static fun prepare(_ databse: Database) throws {
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

extension User {
	static func dataToString(_ data: Data) -> String {
		return String(data: data, encoding: String.Encoding.utf8)!
	}
	static fun stringToData(_ dataString: String) -> Data {
		return dataString.data(using: .utf8)!
	}
}
