// Vedang Yagnik
// 101285281

//  LifeLine.swift
//  WWTBAM
//
//  Created by Vedang Yagnik on 2020-03-24.
//  Copyright © 2020 Vedang Yagnik. All rights reserved.
//

import Foundation

class LifeLine {
    
    let lifeLines = ["Fifty-Fifty(50:50) - Eliminate two wrong options", "Ask The Audience - Audience Voting", "Phone A Friend - Get a probability of answer from a friend"]
    
    //This lifeline will remove two incorrect option
    func fiftyFifty(qa:[String:Any]) -> [String] {
        var updatedOptionsArray: [String]
        updatedOptionsArray = qa["options"] as! [String]
        for (index, opt) in updatedOptionsArray.enumerated().reversed() {
            if(opt != qa["answer"] as! String){
                updatedOptionsArray.remove(at: index)
            }
            if(updatedOptionsArray.count == 2){
                break;
            }
        }

        return updatedOptionsArray
    }
    
    //This lifeline will go for audience voting and show options with no. of percentage
    func askTheAudience(qa:[String:Any]) -> [String:String] {
        var updatedOptionsArray: [String:String] = [:]
        for opt in qa["options"] as! [String] {
            if(opt != qa["answer"] as! String){
                updatedOptionsArray[opt] = opt+" - \(Int.random(in: 20..<50))%"
            } else {
                updatedOptionsArray[opt] = opt+" - \(Int.random(in: 70...90))%"
            }
        }
        
        return updatedOptionsArray
    }
    
    /**This lifeline will call any friend and ask for answer
     * It is not neccessary that friend would know the correct answer. Its your luck...
     */
    func phoneAFriend(qa:[String:Any]) -> [String:String] {
        var updatedOptionsArray: [String:String] = [:]
        let trueAns = Bool.random()
        for opt in qa["options"] as! [String] {
            if (trueAns){
                if (opt == qa["answer"] as! String) {
                    updatedOptionsArray[opt] = opt+" - Answer(100%)"
                } else {
                    updatedOptionsArray[opt] = opt
                }
            } else {
                if (updatedOptionsArray.count==0) {
                    updatedOptionsArray[opt] = opt+" - Might be Answer(\(Int.random(in: 60...80))%)"
                } else {
                    updatedOptionsArray[opt] = opt
                }
            }
        }
        
        return updatedOptionsArray
    }
}
