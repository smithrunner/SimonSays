//
//  Simon.swift
//  SimonSays
//
//  Created by Sam Smith on 8/31/22.
//

import Foundation

struct Simon {
    var choices: [String] = []
    var answer: [String] = ["pink"]
    
    func checkAnswer() -> Bool {
        var i = 0
        while i < choices.count {
            if choices[i] == answer[i] {
                i += 1
            } else {
                return false
            }
        }
        return true
    }
    
    
    mutating func addToAnswer() {
        let c = ["pink","yellow","blue","black"]
        answer.append(c[Int.random(in: 0...3)])
    }
}
