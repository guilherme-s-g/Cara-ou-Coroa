//
//  ContentView.swift
//  Cara ou Coroa
//
//  Created by Guilherme Sabino Queiroz on 20/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var resultado = ""
    @State private var isFlipping = false
    @State private var rotationAngle = 0.0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Cara ou Coroa")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
            
            // Moeda
            ZStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 200, height: 200)
                    .shadow(radius: 10)
                
                Text(resultado.isEmpty ? "?" : (resultado == "Cara" ? "😊" : "👑"))
                    .font(.system(size: 80))
            }
            .rotation3DEffect(
                .degrees(rotationAngle),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 1.0), value: rotationAngle)
            
            if !resultado.isEmpty {
                Text("Resultado: \(resultado)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                jogarMoeda()
            }) {
                Text(isFlipping ? "Girando..." : "Jogar Moeda")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(isFlipping ? Color.gray : Color.blue)
                    .cornerRadius(30)
                    .shadow(radius: 5)
            }
            .disabled(isFlipping)
            
            Spacer()
        }
        .padding()
    }
    
    func jogarMoeda() {
        isFlipping = true
        resultado = ""
        
        // Animação de rotação
        withAnimation(.easeInOut(duration: 1.0)) {
            rotationAngle += 1080 // 3 voltas completas
        }
        
        // Delay para mostrar o resultado após a animação
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let random = Int.random(in: 1...2)
            resultado = random == 1 ? "Cara" : "Coroa"
            isFlipping = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
