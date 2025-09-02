//
//  ContentView.swift
//  swiftUi-Charts
//
//  Created by Jaimin Raval on 21/08/22.
//
//  charts are currently in Beta in iOS 16.0
//  Link to learning  video: https://youtu.be/UCSXF741iHI?si=mn2fa6cRVN8ldTdn

import SwiftUI
import Charts

struct ContentView: View {
    
    var inputs: [Int] {
        var arr = [Int]()
        for i in 1...30 {
            arr.append(i)
        }
        return arr.shuffled()
    }
    
    @State var data = [Int]()
    
    var body: some View {
        VStack {
//            Text("Hello, SwiftUI charts!")
//                .padding()
            Chart {
                ForEach(Array(zip(data.indices,data)), id: \.0) {
                    index, item in
                    BarMark(x:.value("Position", index),y: .value("Value", item))
                }
//                BarMark(x: .value("position", 0), y: .value("Value", 0))
//                BarMark(x: .value("position", 1), y: .value("Value", 1))
//                BarMark(x: .value("position", 2), y: .value("Value", 2))
//                BarMark(x: .value("position", 3), y: .value("Value", 3))
                
            }
            .frame(width: 320, height: 320)
            
            Button {
                Task{
                    try await bubbleSort()
                }
                
            } label: {
                Text("Sort it!")
            }
            
        }
        .onAppear{
            data = inputs
        }
        
    }
    func bubbleSort() async throws {
        guard data.count > 1 else {
            return
        }
        
        for i in 0..<data.count {
            for j in 0..<data.count - i - 1 {
                if data[j] > data[j + 1] {
                    data.swapAt(j + 1, j)
                    try await Task.sleep(until: .now.advanced(by: .milliseconds(20)), clock: .continuous)
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
