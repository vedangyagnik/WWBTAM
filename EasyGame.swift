// Vedang Yagnik
// 101285281

//  EasyGame.swift
//  WWTBAM
//
//  Created by Vedang Yagnik on 2020-03-24.
//  Copyright © 2020 Vedang Yagnik. All rights reserved.
//

import Foundation

class EasyGame: Game, QuestionAndAnswer, Prize{
    //9 questions, Prize and 3 rounds
    var prize = [100, 500, 1000, 8000, 16000, 32000, 125000, 500000, 1000000]
    var qaArray = [
        //-----Round-1------
        [
            "question" : "The International Literacy Day is observed on",
            "options" : ["Sep 8", "Nov 28", "May 2", "Sep 22"],
            "answer" : "Sep 8"
        ],
        [
            "question" : "The language of Lakshadweep. a Union Territory of India, is",
            "options" : ["Tamil", "Hindi", "Malayalam", "Telugu"],
            "answer" : "Malayalam"
        ],
        [
            "question" : "In which group of places the Kumbha Mela is held every twelve years?",
            "options" : ["Ujjain.Purl;Prayag.Haridwar", "Prayag.Haridwar,Ujjain,.Nasik", "Rameshwaram. Purl, Badrinath. Dwarika", "Chittakoot, Ujjain, Prayag,'Haridwar"],
            "answer" : "Prayag.Haridwar,Ujjain,.Nasik"
        ],
        //-----Round-2------
        [
            "question" : "Bahubali festival is related to",
            "options" : ["Islam", "Hinduism", "Buddhism", "Jainism"],
            "answer" : "Buddhism"
        ],
        [
            "question" : "Which day is observed as the World Standards Day?",
            "options" : ["June 26", "Oct 14", "Nov 15", "Dec 2"],
            "answer" : "Oct 14"
        ],
        [
            "question" : "Which of the following was the theme of the World Red Cross and Red Crescent Day?",
            "options" : ["Dignity for all - focus on women", "Dignity for all - focus on Children", "Focus on health for all", "Nourishment for all-focus on children"],
            "answer" : "Dignity for all - focus on Children"
        ],
        //------Round-3-------
        [
            "question" : "September 27 is celebrated every year as",
            "options" : ["Teachers' Day", "National Integration Day", "World Tourism Day", "International Literacy Day"],
            "answer" : "World Tourism Day"
        ],
        [
            "question" : "Who is the author of 'Manas Ka-Hans' ?",
            "options" : ["Khushwant Singh", "Prem Chand", "Jayashankar Prasad", "Amrit Lal Nagar"],
            "answer" : "Amrit Lal Nagar"
        ],
        [
            "question" : "The death anniversary of which of the following leaders is observed as Martyrs' Day?",
            "options" : ["Smt. Indira Gandhi", "PI. Jawaharlal Nehru", "Mahatma Gandhi", "Lal Bahadur Shastri"],
            "answer" : "Mahatma Gandhi"
        ]
    ]

    //Play Game with Easy Difficulty Level
    override func play() {
        var trueAnswersCount = 0
        var round = 1
        
        //Random Q&A Array
        let easyQAArray = self.qaArray.shuffled()
        
        //LifeLines
        let lifeLine = LifeLine.init();
        let lifeLineList = lifeLine.lifeLines

        for (qIndex, qa) in easyQAArray.enumerated() {
            print("-------Round: \(round) ------- Prize: \(self.prize[qIndex])------")
            print("Q\(qIndex+1).\(qa["question"]!)")
            
            //Random Options
            var randomOptionArray:[String] = (qa["options"] as! [String]).shuffled()
            for (index, option) in randomOptionArray.enumerated() {
                print("\(index+1). \(option)")
            }
            print("_______________")
            var answer:Int
            var confirmOption:String
            repeat{
                //Choose Answer or available lifeline from round 1
                print("1. Choose your answer\n2. Use available life line")
                print("Option: ", terminator:"")
                let selOption = Int(readLine()!)!
                
                //For Lifeline
                if(selOption == 2){
                    print("You have 3 life-lines available:")
                    for (index,life) in lifeLineList.enumerated(){
                        print("\(index+1). \(life)")
                    }
                    print("Select lifeline: ", terminator:"")
                    let selLife = Int(readLine()!)!
                    
                    //1. 50-50
                    //2. Audience Voting
                    //3. Phone A Friend
                    var newROA : [String:String] = [:]
                    if (selLife == 1){
                        randomOptionArray = lifeLine.fiftyFifty(qa:qa)
                        //Updated Options
                        print("Q\(qIndex+1).\(qa["question"]!)")
                        for (index, option) in randomOptionArray.enumerated() {
                            print("\(index+1). \(option)")
                        }
                    } else if (selLife == 2){
                        newROA = lifeLine.askTheAudience(qa:qa)
                        //Updated Options
                        print("Q\(qIndex+1).\(qa["question"]!)")
                        for (index, option) in randomOptionArray.enumerated() {
                            print("\(index+1). \(String(describing: newROA[option]!))")
                        }
                    } else {
                        newROA = lifeLine.phoneAFriend(qa:qa)
                        //Updated Options
                        print("Q\(qIndex+1).\(qa["question"]!)")
                        for (index, option) in randomOptionArray.enumerated() {
                            print("\(index+1). \(String(describing: newROA[option]!))")
                        }
                    }
                }
                print("Please select correct answer: ")
                answer = Int(readLine()!)!
                
                //Confirmation for selected answer
                print("Are you sure you want to proceed with this option: ")
                print("Yes")
                print("No")
                confirmOption = readLine()!
            } while(confirmOption.lowercased() == "no")
            if (qa["answer"] as! String == randomOptionArray[answer-1]){
                print("Answer is correct")
                trueAnswersCount += 1
            } else {
                //Any of answer is wrong then lose game with no money
                print("You lose the Game")
                break;
            }
            
            //Round changes after 3 question
            //Player can choose to leave the game after each round
            if([3,6,9].contains(trueAnswersCount)){
                if(trueAnswersCount != 9){
                    print("Take away $\(self.prize[qIndex]) or continue to next round...?")
                    print("1. Quit the Game")
                    print("2. Continue to next round")
                    let continueOrNotAns = Int(readLine()!)!
                    if(continueOrNotAns == 1){
                        print("Qutting game....Great, You have won $\(self.prize[qIndex])")
                        break;
                    }
                    round += 1
                } else {
                    print("Congratulations...You are now millionere. You won $\(self.prize[qIndex])")
                }
            }
        }
    }
}
