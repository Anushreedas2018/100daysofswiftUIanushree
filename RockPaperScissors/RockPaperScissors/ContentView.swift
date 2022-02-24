//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Anushree Das on 23/02/22.
//

import SwiftUI

struct ContentView: View {
    var choices = ["🪨", "📄", "✂️"]
    @State private var appMove = "🪨"
    @State private var score = 0
    @State private var winLose = Bool.random()
    
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var scoreTitle = ""
    @State private var turnCount = 1
    @State private var showingScore = false
    
  
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 50) {
                
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(choices[correctAnswer])
                    .font(.system(size: 80))
                
                HStack {
                    Text (winLose ? "WIN" : "LOOSE")
                        .foregroundColor(winLose ? .green : .yellow)
                        .font(.title)
                        .bold()
                    Text("in this turn!")
                        .font(.title)
                        .foregroundColor(.white)
                    }
                
                HStack {
                    Button(action: {gameLogic(0)}) {
                        Text(choices[0])
                    }
                    .padding()
                    
                    Button(action: {gameLogic(1)}) {
                        Text(choices[1])
                    }
                    .padding()
                    
                    Button(action: {gameLogic(2)}) {
                        Text(choices[2])
                    }
                    .padding()
                    
                }
                .font(.system(size: 70))
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2)
                
                    
                
            }
            
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                if turnCount == 10 {
                    self.restartGame()
                } else {
                    self.askQuestion()
                }
            })
            
        }

    }
    
    func restartGame(){
        correctAnswer = Int.random(in: 0 ... 2)
        winLose = Bool.random()
        score = 0
        turnCount = 1
    }
    
    func askQuestion(){
        turnCount += 1
        correctAnswer = Int.random(in: 0 ... 2)
        winLose = Bool.random()
    }
    
    func gameLogic(_ number: Int) {
        let correct = "Well Done! That's Correct."
        let wrong = "That's Wrong!"
        let draw = "That's a Draw!"
        let roundTen = "You completed 10 rounds! Game will restart"
        
        if turnCount == 10 {
            scoreTitle = roundTen
            showingScore = true
            
        } else {
            switch winLose {
            case false:
                if number == correctAnswer {
                    scoreTitle = draw
                    showingScore = true
                }
                else if number == 0 && correctAnswer == 2 {
                    scoreTitle = wrong
                    showingScore = true
                }
                else if number == 1 && correctAnswer == 0 {
                    scoreTitle = wrong
                    showingScore = true
                }
                else if number == 2 && correctAnswer == 1 {
                    scoreTitle = wrong
                    showingScore = true
                    
                }
                else {
                    scoreTitle = correct
                    showingScore = true
                    score += 1
                }
                
                
            case true:
                
                if number == correctAnswer {
                    scoreTitle = draw
                    showingScore = true
                    score += 1
                }
                else if number == 1 && correctAnswer == 0 {
                    scoreTitle = correct
                    showingScore = true
                    score += 1
                    
                }
                else if number == 2 && correctAnswer == 1 {
                    scoreTitle = correct
                    showingScore = true
                    score += 1
                }
                else if number == 0 && correctAnswer == 2 {
                    scoreTitle = correct
                    showingScore = true
                    score += 1
                }
                else {
                    scoreTitle = wrong
                    showingScore = true
                    
                }
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
