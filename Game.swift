// Vedang Yagnik
// 101285281
//  Game.swift
//  WWTBAM
//
//  Created by Vedang Yagnik on 2020-03-24.
//  Copyright © 2020 Vedang Yagnik. All rights reserved.
//

import Foundation

//Parent Class game
class Game {
    var playerName: String
    
    init(playerName:String) {
        self.playerName = playerName
    }
    
    func play(){
        print("Playing Game...")
    }
}

//Question and Answer Array required in both difficulty Game
protocol QuestionAndAnswer {
    var qaArray:[[String:Any]] {get}
}

//Prize is required in both difficulty game
protocol Prize {
    var prize:[Int] {get}
}
