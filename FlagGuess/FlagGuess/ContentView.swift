//
//  ContentView.swift
//  FlagGuess
//
//  Created by Anushree Das on 10/02/22.
//

import SwiftUI

struct CapsuleFlag: View {
    
    var image: String
    
    var body: some View {
        
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
        
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var resetMessage = ""
    @State private var countries = ["Estonia", "France", "Germany","Ireland","Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var quesNo = 1
    @State private var quesReset = false
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
    VStack {
        Spacer()
        
        Text("Guess the Flag")
            .font(.largeTitle.bold())
            .foregroundColor(.white)
        VStack(spacing: 15) {
        
        VStack {
            
            Text("Question \(quesNo)")
            Text("Tap the flag of")
                .foregroundStyle(.secondary)
                .font(.subheadline.weight(.heavy))
            Text(countries[correctAnswer])
                .foregroundColor(.white)
                .font(.largeTitle.weight(.semibold))
        }
        
        ForEach(0..<3) { number in
            Button ( action: {
                flagTapped(number)
            }) {
                CapsuleFlag(image: self.countries[number])
            }
            
          }

    }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
        Spacer()
        Spacer()
        Text("Score: \(score)")
            .foregroundColor(.white)
            .font(.title.bold())
        
        Spacer()
    }
    .padding()
            
}
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert(resetMessage, isPresented: $quesReset){
            Button("Restart", action: askQuestion)
        }
    
  }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
    showingScore = true
    }
    
    func askQuestion() {
        if quesNo < 8 {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
            quesNo += 1}
        else {
            resetQuiz()
        }
    }
    
    func resetQuiz() {
            quesReset = true
            resetMessage = "The game has ended. Your final score is \(score)"
            quesNo = 0
            score = 0
        
        }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
