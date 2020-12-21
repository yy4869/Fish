//
//  RxExerciseSwiftUIView.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/15.
//  Copyright © 2020 Tutor. All rights reserved.
//

import SwiftUI
import WebKit
import Foundation

struct RxExerciseSwiftUIView : View {

    @State private var languages = ["11", "22", "33"]
    @State private var selectedLanguage = 0
    @State var workingYear: Double = 2
    @State var enableNotification = false

    @State var userName = ""
    @State var password = ""

    var body: some View {
//        NavigationView {
//            Form {
//                Toggle(isOn: $enableNotification) {
//                    if enableNotification {
//                        Text("Disable Notification")
//                    } else {
//                        Text("Enable Notification")
//                    }
//                }
//
//                if enableNotification {
//                    Section(header: Text("Please enter your information:")) {
//                        TextField("Username", text: $userName)
//                        SecureField("Password", text: $password)
//                    }
//                }
//
//                Section(header: Text("Please enter your information:"), footer: Text("Note: Enabling notification to get more infomration")) {
//                    Picker(selection: $selectedLanguage, label: Text("Languages")) {
//                       ForEach(0 ..< languages.count) {
//                        Text(self.languages[$0]).tag($0)
//                       }
//                    }.pickerStyle(SegmentedPickerStyle())
//                    HStack{
//                        Text("Working years")
//                        Slider(value: $workingYear, in: 1...10, step: 1)
//                    }
//                }
//                Button(action: {
//                    print("Your programming language: \(self.languages[self.selectedLanguage])")
//                    print("Your working years: \(Int(self.workingYear))")
//                    print("Enable notification: \(self.enableNotification)")
//                }) {
//                    Text("Submit")
//                }
//            }.navigationBarTitle(Text("Profiles"))
//        }

        NavigationView {
            List {
                ForEach(languages, id: \.self) { title in
                    NavigationLink(destination: MyDetailView(message: title)) {
                        Text(title).font(.system(size: 30)).padding()
                    }
                }
            }
        }
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

struct MyDetailView: View {
    let message: String

    var body: some View {
        VStack {
            Text(message)
        }
    }
}

struct MyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyDetailView(message: "")
    }
}
