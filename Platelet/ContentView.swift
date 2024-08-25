//
//  ContentView.swift
//  Platelet
//
//  Created by Ethan Zhang on 25/8/2024.
//

//
//  ContentView.swift
//  test1
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
struct ContentView: View {
    @State private var clicked = false

    var body: some View {
        
            PlateletImage(clicked: clicked)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            clicked = true
                        })
                        .onEnded({ _ in
                            clicked = false;
                        })
                )
        
        .ignoresSafeArea()
    }
}

struct PlateletImage: View {
    var clicked: Bool

    var body: some View {
        Group {
            if clicked {
                Image("platelet image2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
            } else {
                Image("platelet image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
