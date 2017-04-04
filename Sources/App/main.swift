import Vapor
import VaporMySQL
import Auth

let drop = Droplet()
try drop.addProvider(VaporMySQL.Provider.self)

drop.preparations.append(Question.self)
drop.preparations.append(User.self)

// Adding middleware for authentication
// Session management
drop.addConfigurable(middleware: AuthMiddleware(user: User.self), name: "auth")

let question = QuestionConroller()
question.addRoutes(drop: drop)

let user = UserController()
user.addRoutes(drop: drop)

drop.run()
