//
//  ContentView.swift
//  GuessFlag
//
//  Created by Sergey Lobanov on 20.10.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["uk", "usa", "bangladesh", "germany", "argentina",
                                    "brazil", "canada", "greece", "russia", "sweden"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .white]),
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Выберите флаг:")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .frame(width: 250, height: 125)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule().stroke(.black, lineWidth: 1))
                            .shadow(color: .black, radius: 50)
                    }
                }
                
                Text("Общий счет: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text("Общий счет: \(score)"),
                dismissButton: .default(Text("Продолжить")) {
                    self.askQuestion()
                })
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Правильный ответ"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
