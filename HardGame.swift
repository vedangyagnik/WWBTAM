// Vedang Yagnik
// 101285281

//  HardGame.swift
//  WWTBAM
//
//  Created by Vedang Yagnik on 2020-03-24.
//  Copyright © 2020 Vedang Yagnik. All rights reserved.
//

import Foundation

class HardGame : Game, QuestionAndAnswer, Prize{
    //15 questions, Prize and 3 rounds
    var prize = [100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 125000, 250000, 500000, 1000000]
    var qaArray = [
        //-----Round-1-------
        [
            "question" : "Nandyal is situated in",
            "options" : ["Karnataka", "AndhraPradesh", "Maharashtra", "Madhya Pradesh"],
            "answer" : "Karnataka"
        ],
        [
            "question" : "The Krithi system was perfected and Carnatic music was given by",
            "options" : ["Arunagirinathan", "Purandaradasa", "Shyama Shastri", "Swati Tirunal"],
            "answer" : "Swati Tirunal"
        ],
        [
            "question" : "Central Salt and Marine Chemicals Research Institute is located at",
            "options" : ["Ahmedabad", "Bhavnagar", "Gandhinagar", "Panaji"],
            "answer" : "Panaji"
        ],
        [
            "question" : "Which of the followiing is a folk dance of India?",
            "options" : ["Kathakali", "Mohiniattam", "Garba", "Manipuri"],
            "answer" : "Garba"
        ],
        [
            "question" : "Which one of the following is essentially a solo dance?",
            "options" : ["Kuchipudi", "Kathak", "Manipuri", "Mohiniattam"],
            "answer" : "Mohiniattam"
        ],
        //-----Round-2-------
        [
            "question" : "The Lalit Kala Academy is devoted to the promotion of",
            "options" : ["Dance & Drama", "Fine Arts", "Literature", "Music"],
            "answer" : "Fine Arts"
        ],
        [
            "question" : "Onam is the main festival of",
            "options" : ["Tamil Nadu", "Karnataka", "Andhra Pradesh", "Kerala"],
            "answer" : "Kerala"
        ],
        [
            "question" : "Rath Yatra is famous festival at",
            "options" : ["Ayodhyah", "Mathura", "Dwaraka", "Puri"],
            "answer" : "Puri"
        ],
        [
            "question" : "The first month of the Indian national calendar is",
            "options" : ["Magha", "Chaitra", "Ashadha", "Vaishakha"],
            "answer" : "Chaitra"
        ],
        //------Round-3-------
        [
            "question" : "Van Mahotsav was started by",
            "options" : ["Maharshi Karve", "Bal Gangadhar Tiiak", "K.M, Munshi", "Sanjay Gandhi"],
            "answer" : "K.M, Munshi"
        ],
        [
            "question" : "Which of the following Muslim festivals is based on the 'Holy Quran' ?",
            "options" : ["Id -ul-Zuha", "Id -ul-Fitr", "Bakri-id", "Moharram"],
            "answer" : "Id -ul-Zuha"
        ],
        [
            "question" : "Ghototkach in Mahabharat was the son of",
            "options" : ["Duryodhana", "Arjuna", "Yudhishthir", "Bhima"],
            "answer" : "Bhima"
        ],
        [
            "question" : "Pongal is a popular festival of which state?",
            "options" : ["Karnataka", "Kerala", "Tamil Nadu", "Andhra Pradesh"],
            "answer" : "Tamil Nadu"
        ],
        [
            "question" : "World Health Day is observed on",
            "options" : ["Apr 7", "Mar 6", "Mat I5", "Apr 28"],
            "answer" : "Apr 7"
        ],
    ]

    //Play Game with Hard Difficulty Level
    override func play() {
        var trueAnswersCount = 0
        var round = 1
        
        //Random Q&A Array
        let hardQAArray = self.qaArray.shuffled()
        
        //LifeLines
        let lifeLine = LifeLine.init();
        let lifeLineList = lifeLine.lifeLines

        for (qIndex, qa) in hardQAArray.enumerated() {
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
                //Choose Answer
                //Life lines are available from round 2
                if (round > 1) {
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
                }
                print("Please select correct answer: ")
                answer = Int(readLine()!)!
                
                //Confirmation for selected answer
                print("Are you sure you want to proceed with this option: ")
                print("Yes")
                print("No")
                confirmOption = readLine()!
            } while(confirmOption == "No")
            if (qa["answer"] as! String == randomOptionArray[answer-1]){
                print("Answer is correct")
                trueAnswersCount += 1
            } else {
                //Any of answer is wrong then lose game with no money
                print("You lose the Game")
                break;
            }
            
            //Round changes after 5 question
            //Player can choose to leave the game after each round
            if([5,10,15].contains(trueAnswersCount)){
                if(trueAnswersCount != 15){
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
