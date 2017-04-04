//
//  UserController.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/3/17.
//
//

import Vapor
import HTTP
import Turnstile

final class UserController {
    func addRoutes(drop: Droplet) {
        let question = drop.grouped("user")
        question.post("register", handler: register)
        question.get("users", handler: getUsers)
    }
    
    // Register user
    func register(request: Request) throws -> ResponseRepresentable {
        let user = try User(node: request.json)
        let username = user.username
        let password = user.password
        _ = try User.register(username: username, rawPassword: password)
        
        let credentials = UsernamePassword(username: username, password: password)
        try request.auth.login(credentials)
        return username
    }
    
    func getUsers(request: Request) throws -> ResponseRepresentable {
        let users = try User.all().makeNode()
        let usersDictionary = ["users": users]
        return try JSON(node: usersDictionary)
    }
}

