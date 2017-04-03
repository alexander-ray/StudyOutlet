import Vapor
import VaporMySQL

let drop = Droplet()
try drop.addProvider(VaporMySQL.Provider.self)

drop.preparations.append(Question.self)

drop.get("hello") { request in
    let name = request.data["name"]?.string ?? "stranger"

    return try drop.view.make("hello", [
        "name":name
    ])
}

drop.post("question") { req in
    /*let q = req.data["question"]?.string
    let s = req.data["solution"]?.string?.data(using: .utf8)
    let answer = req.data["answer"]?.string
    let subject = req.data["topic"]?.string
    let topic = req.data["subject"]?.string
    var question = Question(question: q!, solution: s!, answer: answer!, subject: subject!, topic: topic!)*/
    var question = try Question(node: req.json)
    try question.save()
    return question.subject
}

drop.get("question") {req in
    let questions = try Question.all().makeNode()
    let questionsDictionary = ["questions": questions]
    return try JSON(node: questionsDictionary)
}

drop.get("question", Int.self) { req, questionId in
    guard let question = try Question.find(questionId) else {
        throw Abort.notFound
    }
    let questionStr = question.question
    return questionStr
}
drop.run()
