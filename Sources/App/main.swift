import Vapor
import VaporMySQL
import Auth

let drop = Droplet()
try drop.addProvider(VaporMySQL.Provider.self)

// Adding middleware for authentication
// Session management
let auth = AuthMiddleware(user: User.self)
drop.middleware.append(auth)
drop.preparations = [User.self]

drop.preparations.append(Question.self)
drop.preparations.append(User.self)

let question = QuestionConroller()
question.addRoutes(drop: drop)

let user = UserController()
user.addRoutes(drop: drop)

drop.run()
