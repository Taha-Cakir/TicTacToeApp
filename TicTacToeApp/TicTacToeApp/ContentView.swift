//
//  ContentView.swift
//  TicTacToeApp
//
//  Created by Taha Cakir on 10.02.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("tic tac toe")
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
            
        }
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
//    moves..
    @State var moves : [String] = Array (repeating: "", count: 9)
//    to identify curret player...
    @State var isPlaying = true
    @State var gameOver = false
    @State var msg = ""
//    checkmoves tan sonra bu son iki tanımlandı
    
    var body: some View{
        
        VStack{
            
            
            
            
            
            
//            gridview for Playing
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 15){
                
                ForEach(0..<9,id:\.self){index in
                    
                    
                    ZStack {
//                        Flip animation
                        Color.white
                        
                        
                        Color.blue
                            .opacity(moves[index] != "" ? 1 : 0)
                        
                        Text(moves[index])
                            .font(Font.system(size: 55.0))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .opacity(moves[index] != "" ? 1 : 0)
                            
                    }
                    .frame(width: getWidth(), height: getWidth())
                    .cornerRadius(15)
                    .rotation3DEffect(
                        .init(degrees: moves[index] != "" ? 180 : 0),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/,
                        anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                        anchorZ: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                        perspective: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/
                    )
//                    whenever tapped adding moves..
                    .onTapGesture(perform: {
                        withAnimation(Animation.easeIn(duration: 0.5)){
                            if moves[index] == ""{
                                moves[index] = isPlaying ? "x" : "o"
                                //                            updating player ..
                                isPlaying.toggle()
                            }
//
                        }
                    })
                }
            }
            .padding(15)
        }
//        whenever moves updated it will check winner.
        .onChange(of: moves, perform: { value in
            checkWinner()
        })
        .alert(isPresented: $gameOver, content: {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton: .destructive(Text("Play again :("), action: {
                
//                reseting all data..
                withAnimation(Animation.easeIn(duration: 0.5)){
                    
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
            
        })
    }
        //    calculating width
        func getWidth()-> CGFloat{
//            horizontal padding
//            spacing = 30
            
            let width = UIScreen.main.bounds.width - (30 + 30)
            return width / 3
        
        }
//      checking for winner..
    func checkWinner(){
        if checkMoves(player: "x"){
            msg = "X wins !"
            
            gameOver.toggle()
            
                
            
        }
        else if checkMoves(player: "o"){
            msg = "Player O won !"
            gameOver.toggle()
        }
        else{
//            checking no moves
            let status = moves.contains{ (value) -> Bool in
                return value == ""
        }
            if !status{
                msg = "Game Over"
                gameOver.toggle()
            }
        }
    }
    func checkMoves(player : String)->Bool{
//        horizontal moves
        for i in stride(from: 0, to: 9, by: 3){
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player{
                return true
            }
        }
//        vertical moves
        for i in 0...2{
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player{
                
                return true
            }
        }
        if moves[0] == player && moves[4] == player && moves [8] == player {
            return true
        }
        if moves[2] == player && moves[4] == player && moves [6] == player {
            return true
        
        }
        return false
    }
    }
    
    

//cornerradius aralıktır
