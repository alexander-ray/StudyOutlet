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
import Auth

final class UserController {
    /*func addRoutes(drop: Droplet) {
        let user = drop.grouped("user")
        user.post("register", handler: register)
        user.get("users", handler: getUsers)
        user.post("login", handler: login)
    }*/
    
    // Register user
    func register(request: Request) throws -> ResponseRepresentable {
        // Get info
        guard let username = request.formURLEncoded?["username"]?.string,
            let password = request.formURLEncoded?["password"]?.string else {
                return "Missing username or password"
        }
        let credentials = UsernamePassword(username: username, password: password)

        do {
            try _ = User.register(credentials: credentials)
            try request.auth.login(credentials)
            return username
        } catch let e as TurnstileError {
            return e.description
        }
    }
    // User login
    func login(request: Request) throws -> ResponseRepresentable {
        // Get info
        //let user = try User(node: request.json)
        //let username = user.username
        //let password = user.password
        guard let username = request.formURLEncoded?["username"]?.string,
            let password = request.formURLEncoded?["password"]?.string else {
                return "Missing username or password"
        }
        // Try to login
        let credentials = UsernamePassword(username: username, password: password)
        do {
            try request.auth.login(credentials)
            let accessKey = try User.getAccessKey(username: username)
            return accessKey
        } catch let e as TurnstileError {
            return e.description
        }
    }
    
    func getUsers(request: Request) throws -> ResponseRepresentable {
        let users = try User.all().makeNode()
        let usersDictionary = ["users": users]
        return try JSON(node: usersDictionary)
    }
    
}

