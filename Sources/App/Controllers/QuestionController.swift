//
//  QuestionControllers.swift
//  StudyOutlet
//
//  Created by Alex Ray on 4/3/17.
//
//

import Vapor
import HTTP
import Turnstile

final class QuestionConroller {
    /*func addRoutes(drop: Droplet) {
        let question = drop.grouped("question")
        question.post("questions", handler: addQuestion)
        question.get("questions", handler: getQuestions)
    }*/
    // Add question
    func addQuestion(request: Request) throws -> ResponseRepresentable {
        var question = try Question(node: request.json)
        try question.save()
        return question.subject
    }
    
    // Get all questions
    func getQuestions(request: Request) throws -> ResponseRepresentable {
        let questions = try Question.all().makeNode()
        //let questionsDictionary = ["questions": questions]
        return try JSON(node: questions)
    }
}
