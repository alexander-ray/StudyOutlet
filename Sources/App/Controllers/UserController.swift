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
        let user = drop.grouped("user")
        user.post("register", handler: register)
        user.get("users", handler: getUsers)
        user.post("login", handler: login)
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
    
    func login(request: Request) throws -> ResponseRepresentable {
        let user = try User(node: request.json)
        let username = user.username
        let password = user.password
        let credentials = UsernamePassword(username: username, password: password)
        do {
            try request.auth.login(credentials)
            return username
        } catch let e as TurnstileError {
            return e.description
        }
    }
}

