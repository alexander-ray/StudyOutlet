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
    // Register user
    func register(request: Request) throws -> ResponseRepresentable {
        // Get username and password from url
        guard let email = request.formURLEncoded?["email"]?.string,
            let password = request.formURLEncoded?["password"]?.string else {
                return "Missing username or password"
        }
        let credentials = UsernamePassword(username: email, password: password)

        do {
            try _ = User.register(credentials: credentials) // Register and throw away result
            try request.auth.login(credentials)
            return email
        } catch let e as TurnstileError {
            return e.description
        }
    }
    // User login
    func login(request: Request) throws -> ResponseRepresentable {
        // Get username and password from url
        guard let email = request.formURLEncoded?["email"]?.string,
            let password = request.formURLEncoded?["password"]?.string else {
                return "Missing username or password"
        }
        let credentials = UsernamePassword(username: email, password: password)
        do {
            try request.auth.login(credentials) // Try to login
            // Get access key for user
            // Will have successfully logged in
            let accessKey = try User.getAccessKey(email: email)
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

