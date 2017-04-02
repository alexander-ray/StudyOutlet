import Vapor
import VaporMySQL

let drop = Droplet()
drop.preparations.append(Question.self)

try drop.addProvider(VaporMySQL.Provider.self)

drop.get("hello") { request in
    let name = request.data["name"]?.string ?? "stranger"

    return try drop.view.make("hello", [
        "name":name
    ])
}

/*drop.post("question") { req in
    var question = try Question(node: req.json)
    try question.save()
    return try question.makeJSON()
}*/

drop.run()
