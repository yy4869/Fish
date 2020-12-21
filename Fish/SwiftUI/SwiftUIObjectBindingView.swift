//
//  SwiftUIObjectBindingView.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/21.
//  Copyright © 2020 Tutor. All rights reserved.
//

import SwiftUI

class UserModel: ObservableObject {
    @Published var name: String = ""
}

struct SwiftUIObjectBindingView: View {
    @State private var name: String = ""
    @State var isPresented = false
//    @ObservedObject var model = UserModel()
    @EnvironmentObject var model: UserModel

    var alert: Alert {
        Alert(title: Text("Your name"), message: Text(model.name), dismissButton: .cancel())
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Your name", text: $model.name).padding()
    //            Button("show", action: {
    //                self.isPresented = true
    //            }).alert(isPresented: $isPresented, content: {
    //                alert
    //            })
//                NavigationLink(destination: SwiftUISubView()) {
//                    Text("Show Detail")
//                }
                Button("Show modal view") {
                    isPresented = true
                }.sheet(isPresented: $isPresented, content: {
                    modalView
                })
            }
        }
    }

    var modalView: some View {
        Text("The modal view")
    }
}

struct SwiftUIObjectBindingView_Previews: PreviewProvider {
    static var previews: some View {
        return SwiftUIObjectBindingView().environmentObject(UserModel())
    }
}

struct SwiftUISubView: View {
    // EnvironmentObject 好用是好用，但是需要在子试图里重新写一个变量，这就有可能造成命名不统一的问题，肉眼可见有坑
    @EnvironmentObject var model: UserModel

    var body: some View {
        Text("name: \(model.name)")
    }
}
