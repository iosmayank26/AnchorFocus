//
//  ContentView.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    @State var startDate = Date.now
    @State var timeElapsed: Int = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.red)
            Text("Timer: \(timeElapsed) sec")
            // 2
                .onReceive(timer) { firedDate in
                    
                    print("timer fired")
                    // 3
                    timeElapsed = Int(firedDate.timeIntervalSince(startDate))
                }
                .font(.largeTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
