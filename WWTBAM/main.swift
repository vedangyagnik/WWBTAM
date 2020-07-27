// Vedang Yagnik
// 101285281
//  main.swift
//  WWTBAM
//
//  Created by Vedang Yagnik on 2020-03-24.
//  Copyright © 2020 Vedang Yagnik. All rights reserved.
//

import Foundation

//Get Player Name
print("Enter your name: ", terminator: "")
let name = readLine()!
let newGame = Game.init(playerName: name)

print(".........Welcome \"\(newGame.playerName)\" to the game show.........")

//Select Game Difficulty
print("Please select game difficulty: ")
print("1: Easy")
print("2: Hard")
print("option: ", terminator:"")
let gameDifficulty = Int(readLine()!)!

//Play game as per selected difficulty
if (gameDifficulty == 1){
    let easyGame = EasyGame.init(playerName: name)
    easyGame.play()
} else {
    let hardGame = HardGame.init(playerName: name)
    hardGame.play()
}
