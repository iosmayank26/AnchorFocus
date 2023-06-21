//
//  ContentView.swift
//  PomoFocus
//
//  Created by Mayank Gupta on 23/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Timer done!", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        // Code
                    }
                }
                .padding()
                .frame(width: width)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 4)
                )
            
            
            Slider(value: $vm.minutes, in: 1...10, step: 1)
                .padding()
                .disabled(vm.isActive)
                .animation(.easeInOut, value: vm.minutes)
                .frame(width: width)
            
            HStack(spacing:50) {
                Button("Start") {
                    vm.start(minutes: vm.minutes)
                }
                .font(.system(size: 25, weight: .medium))
                .disabled(vm.isActive)
                .padding()
                .tint(.white)
                .background(.purple)
                .cornerRadius(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.purple, lineWidth: 4)
                }
                
                Button("Reset", action: vm.reset)
                    .font(.system(size: 25, weight: .medium))
                    .padding()
                    .tint(.purple)
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.purple, lineWidth: 4)
                    }
            }
            .frame(width: width)
        }
        .onReceive(timer) { _ in
            vm.updateCountdown()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
