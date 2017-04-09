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


//let question = QuestionController()
//question.addRoutes(drop: drop)
//let user = UserController()
//user.addRoutes(drop: drop)

//drop.run()*/

drop.group("api") { api in
    api.group("user") { user in
        
        let userController = UserController()
        
        /*
         * Registration
         * Create a new Username and Password to receive an authorization token and account
         */
        user.post("register", handler: userController.register)
        
        /*
         * Log In
         * Pass the Username and Password to receive a new token
         */
        user.post("login", handler: userController.login)
        // User login
        
        /*
         * Secured Endpoints
         * Anything in here requires the Authorication header:
         * Example: "Authorization: Bearer TOKEN"
         */
        let protect = ProtectMiddleware(error: Abort.custom(status: .unauthorized, message: "Unauthorized"))
        user.group(BearerAuthenticationMiddleware(), protect) { secured in
            let users = secured.grouped("users")
            users.get("users", handler: userController.getUsers)
        }
    }
    api.group("question") { question in
        let questionController = QuestionConroller()
        
        /*
         * Secured Endpoints
         * Anything in here requires the Authorication header:
         * Example: "Authorization: Bearer TOKEN"
         */
        let protect = ProtectMiddleware(error: Abort.custom(status: .unauthorized, message: "Unauthorized"))
        question.group(BearerAuthenticationMiddleware(), protect) { secured in
            let questions = secured.grouped("questions")
            questions.post("questions", handler: questionController.addQuestion)
            questions.get("questions", handler: questionController.getQuestions)
        }

    }
}

drop.run()
