import Vapor
import VaporMySQL
import Auth
import Turnstile
import TurnstileCrypto
import TurnstileWeb
import Fluent

let drop = Droplet()
try drop.addProvider(VaporMySQL.Provider.self)

drop.preparations.append(Question.self)
drop.preparations.append(User.self)
drop.middleware.append(AuthMiddleware(user: User.self))

let protect = ProtectMiddleware(error: Abort.custom(status: .unauthorized, message: "Unauthorized"))
let userController = UserController()
let questionController = QuestionConroller()
drop.group("api") { api in
    /*
     * Registration
     * Create a new Username and Password to receive an authorization token and account
     */
    api.post("register", handler: userController.register)
    
    /*
     * Log In
     * Pass the Username and Password to receive a new token
     */
    api.post("login", handler: userController.login)
    
    // Protected user endpoints
    api.group(BearerAuthenticationMiddleware(), protect) { user in
        user.get("users", handler: userController.getUsers)
    }
    // Protected question endpoints
    api.group(BearerAuthenticationMiddleware(), protect) { question in
        question.post("questions", handler: questionController.addQuestion)
        question.get("questions", handler: questionController.getQuestions)
    }
}

drop.run()
