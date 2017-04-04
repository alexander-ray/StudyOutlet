import Vapor
import VaporMySQL

let drop = Droplet()
try drop.addProvider(VaporMySQL.Provider.self)

drop.preparations.append(Question.self)
drop.preparations.append(User.self)

drop.get("hello") { request in
    let name = request.data["name"]?.string ?? "stranger"

    return try drop.view.make("hello", [
        "name":name
    ])
}

// MARK: - User routes
drop.post("register") {req in
    var user = try User(node: req.json)
    try user.save()
    return user.username.value
}
// Get all users
drop.get("users") {req in
    let users = try User.all().makeNode()
    let usersDictionary = ["users": users]
    return try JSON(node: usersDictionary)
}
// Get user with specified ID
drop.get("user", Int.self) { req, userId in
    guard let user = try User.find(userId) else {
        throw Abort.notFound
    }
    return try user.makeJSON()
}


// MARK: - Question routes
// Create new question
drop.post("question") { req in
    var question = try Question(node: req.json)
    try question.save()
    return question.subject
}
// Get all questions
drop.get("questions") {req in
    let questions = try Question.all().makeNode()
    let questionsDictionary = ["questions": questions]
    return try JSON(node: questionsDictionary)
}
// Get question with specified ID
drop.get("question", Int.self) { req, questionId in
    guard let question = try Question.find(questionId) else {
        throw Abort.notFound
    }
    return try question.makeJSON()
}
drop.run()
