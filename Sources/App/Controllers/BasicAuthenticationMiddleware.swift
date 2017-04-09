//
//  BasicAuthenticationMiddleware.swift
//  VaporAuth
//
//  Created by Edward Jiang on 10/3/16.
//
//
import Vapor
import HTTP
import Turnstile

/**
 Takes a Basic Authentication header and turns it into a set of API Keys,
 and attempts to authenticate against it.
 */
class BearerAuthenticationMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        if let accessKey = request.auth.header?.bearer {
            try? request.auth.login(accessKey, persist: false)
        }
        
        return try next.respond(to: request)
    }
}
