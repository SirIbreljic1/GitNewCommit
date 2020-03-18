//
//  ContentView.swift
//  RevereWaterSewerApp
//
//  Created by Ahmed Ibreljic on 3/5/20.
//  Copyright © 2020 Ahmed Ibreljic. All rights reserved.
//
//Text("Welcome back user!")

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    @State var open = false
    
    func getUser() {
        session.listen()
        
    }
    
    var body: some View {
        Group {
            if(session.session != nil) {
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Button(action: {self.open.toggle()}) {
                                Image(systemName: "line.horizontal.3")
                                  .imageScale(.large)
                                  .foregroundColor(.black)
                            }
                        }
                        Spacer()
                    }.padding()
                    Menu(open: $open)
                }
            }
            else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct Menu: View {
  @Binding var open: Bool

  var body: some View {
    VStack {
      HStack {
        Text(verbatim: "gear")
            // verbatim was actually called systemName before, but Xcode "fixes" it
          .foregroundColor(.blue)
          .font(.system(size: 24, weight: .heavy))
          .frame(width: 32, height: 32)
        
        ZStack  {
            Image("user")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(.horizontal, 24)
            
            Circle()
                .stroke(Color("Purple"))
                .frame(width: 70, height: 70)
                .offset(x: -2, y: -1)
            
            Circle()
                .stroke(Color("Green"))
                .frame(width: 70, height: 70)
                .offset(x: 2, y: 1)
        }
        
        Image(systemName: "pencil")
            .foregroundColor(.blue)
            .font(.system(size: 24, weight: .heavy))
            .frame(width: 32, height: 32)
        
      }
      .padding(.top, 20)

        Text("Ahmed Ibreljic")
            .foregroundColor(.blue)
            .font(.system(size: 20, weight: .semibold))
            .padding(.top, 10)
            .padding(.bottom, 40)
        
        
      Row(rowActive: false, icon: "house", text: "Home")
      Row(rowActive: false, icon: "person", text: "Profile")
      Row(rowActive: false, icon: "plus", text: "Add Equipment")
      Row(rowActive: false, icon: "book", text: "Inventory")

      Spacer()
        
      NavigationView(destination: AuthView()) {
          Image(systemName: "arrow.uturn.left")
            .imageScale(.large)
            .foregroundColor(.black)
          Text("Sign out")
        
        // if (systemName)
        //
      }
    }
   
    .padding(.vertical, 30)
    .background(LinearGradient(gradient: Gradient(colors: [Color("Blue"),  Color("Purple")]), startPoint: .top, endPoint: .bottom))
    .padding(.trailing, 80)
    .edgesIgnoringSafeArea(.vertical)
    .offset(x: open ? 0 : -UIScreen.main.bounds.width)
    .rotation3DEffect(Angle(degrees: open ? 0 : 45), axis: (x: 0, y: 20, z: 0))
    .animation(.default)
    .onTapGesture {
      self.open.toggle()
    }
  }
}

struct Row: View {
  var rowActive: Bool
  var icon = "house"
  var text = "Dashboard"

  var body: some View {
    HStack {
        Image(systemName: icon)
          .foregroundColor(rowActive ? Color("Purple") : .blue)
          .font(.system(size: 15, weight: rowActive ? .bold : .regular))
          .frame(width: 48, height: 32)

          Text(text)
            .foregroundColor(rowActive ? Color("Purple") : .blue)
            .font(.system(size: 15, weight: rowActive ? .bold : .regular))

        Spacer()
            // Video 8:34
    }
    .padding(4)
    .background(rowActive ? Color.blue: Color.red.opacity(0))
    .padding(.trailing, 20)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .offset(x: 20)
  }
}

    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View  {
        ContentView().environmentObject(SessionStore())
        
        // Video @7:08
    }
}
