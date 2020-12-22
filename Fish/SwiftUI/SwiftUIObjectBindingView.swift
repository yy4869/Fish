//
//  SwiftUIObjectBindingView.swift
//  Fish
//
//  Created by yaoyuan on 2020/12/21.
//  Copyright © 2020 Tutor. All rights reserved.
//

import SwiftUI

struct SwiftUIObjectBindingView: View {

    let icon = Image(systemName: "book.fill")
    let title = Text("Interactive Tutorials")
    let flag = Image(systemName: "icloud.and.arrow.down")

    @State var isPresent = false
    private var randomBool = Bool.random()

    var body: some View {
//        if randomBool {
//            // AnyView 可以忽略具体的View的类型，这样返回的就是同一类型，相当于骗过编译器
//            return AnyView(Image(systemName: "star.fill").font(.system(size: 72)))
//        } else {
//            return AnyView(Text("Sorry, you miss the gift.").font(.system(size: 32)))
//        }
        NavigationView {
            VStack {
                Text("SwiftUI's NavigationView")
                    .navigationBarTitle(Text("SwiftUI"))
                    .navigationBarItems(leading: Button(action: {
                        print("leading button pressed")
                    }, label: {
                        Text("Button1")
                    }), trailing: TrailingButtons())
                    .padding()

                // navigationBarTitle 按顺序来，前面设置过了，后面就不生效了
                Text("hehe").navigationBarTitle(Text("11"))

                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 40) {
                    Image("logo").modifier(myImageStyle())
                }
            }
        }
    }
}

struct myImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Circle().fill(Color.yellow))
            .clipped()
            .overlay(Circle().stroke(Color.blue, lineWidth: 5))
            .saturation(0)
    }

}


struct TrailingButtons: View {
    var body: some View {
        HStack {
            Button(action: {
                print("trailing button pressed 1")
            }, label: {
                Image(systemName: "icloud.and.arrow.down.fill")
            })

            Button(action: {
                print("trailing button pressed 2")
            }, label: {
                Image(systemName: "pencil.tip.crop.circle")
            })
        }
    }
}

struct SwiftUIObjectBindingView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIObjectBindingView()
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail")
            .onAppear {
                print("view on appear")
            }
            .onDisappear {
                print("view on disappear")
            }
    }
}
