import Vapor
import Fluent
import Foundation

// Model for a question
final class Question: Model {
    // Fields from database to fully represent question
    var id: Node? // Identifier to comform to model
    // Question and solution contain base64 png to deal with Blob type
    let question: String
    let solution: String
    let answer: String
    let subject: String
    let topic: String
    
    var exists: Bool = false

    // Initialize values
    init(question: String, solution: String, answer: String, subject: String, topic: String) {
        self.question = question
        self.solution = solution
        self.answer = answer
        self.subject = subject
        self.topic = topic
    }
    
    // Getting data from database
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        question = try node.extract("question")
        //question = try node.extract("question", transform: Question.stringToData)
        //solution = try node.extract("solution", transform: Question.stringToData)
        solution = try node.extract("solution")
        answer = try node.extract("answer")
        subject = try node.extract("subject")
        topic = try node.extract("topic")
    }
    
    // Insert info into database
    // Probably unused
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            // Node data type can only use strings, ints, etc
            "question": question,
            //"question": question,
            "solution": solution,
            "answer": answer,
            "subject": subject,
            "topic": topic
        ])
    }
    
    // Needed to conform to model
    // Creates table if needed
    static func prepare(_ database: Database) throws {
        try database.create("questions") { questions in
            questions.id()
            questions.data("question")
            questions.data("solution")
            questions.string("answer")
            questions.string("subject")
            questions.string("topic")
        }
    }
    static func revert(_ database: Database) throws {
        try database.delete("questions")
    }
}
