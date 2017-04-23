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
 Takes a Bearer Authentication header and turns it into a set of access keys,
 and attempts to authenticate against it.
 */
class BearerAuthenticationMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        // Let accessKey = Bearer
        if let accessKey = request.auth.header?.bearer {
            try? request.auth.login(accessKey, persist: false) // Try to login
        }
        return try next.respond(to: request)
    }
}
