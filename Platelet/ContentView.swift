//
//  ContentView.swift
//  Platelet
//
//  Created by Ethan Zhang on 25/8/2024.
//

import SwiftUI

//struct ContentView: View {
//    var body: some View {
//        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Hello, world!")
//            var clicked = false
//            Button {
//                        clicked = !clicked
//                    } label: {
//                        PlateletImage(clicked: clicked)
//                    }
//
//        }
//
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}


//struct ContentView: View {
//    @State private var clicked = false
//    @State private var count = 0
//
//
//    var body: some View {
//        
//        HStack {
//            Text("Tap Count: \(count)") // Display the tap count
//                .font(.largeTitle)
//                .padding()
//                .allowsHitTesting(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
//            PlateletImage(clicked: clicked)
//                .onLongPressGesture(minimumDuration: 1.0, pressing: { pressing in
//                                // This closure will be called when the gesture state changes
//                                clicked = pressing
//                    print("Long press started")
//
//                            }) {
//                                // This closure will be called when the long press gesture is completed
//                                print("Long press completed")
//                            }
////                    .gesture(
////                        LongPressGesture(minimumDuration: 5 )
////                            .onChanged({ _ in
////                                clicked = true
////                                count+=1
////                                print("click hold")
////
////                            })
////                            .onEnded({ _ in
////                                clicked = false
////                                print("click release")
////                            })
////                )                
//                    .ignoresSafeArea()
//        }
//
//        
//    }
//}
struct ContentView: View {
    @State private var isPressed = false
    @State private var touchCount = 0

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(isPressed ? "platelet image2" : "platelet image")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !isPressed {
                                isPressed = true
                                touchCount += 1
                            }
                        }
                        .onEnded { _ in
                            isPressed = false
                        }
                )
            
            Text("Poke Count: \(touchCount)")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.medium)
                .foregroundStyle(Color(red: 0.599, green: 0.412, blue: 0.409))
                .padding(.bottom, 17.238)
        }
    }
}


struct PlateletImage: View {
    var clicked: Bool
    var count = 0
    var body: some View {
   
            if clicked {
                Image("platelet image2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                Image("platelet image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
