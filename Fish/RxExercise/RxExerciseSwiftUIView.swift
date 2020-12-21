//
//  RxExerciseSwiftUIView.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/15.
//  Copyright © 2020 Tutor. All rights reserved.
//

import SwiftUI
import WebKit

struct RxExerciseSwiftUIView : View {

    var body: some View {
        Group {
            Text("Apple")
            Text("Banana")
            Text("Orange")
            Text("Watermelon")
            Text("Grape")
            Text("Papaya")
            Text("Pear")
        }
        .font(.title)
        .foregroundColor(.orange)
        .padding()
    }
}


struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .cornerRadius(5)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct RxExerciseSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        RxExerciseSwiftUIView()
    }
}

