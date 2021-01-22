//
//  ContentView.swift
//  UI-108
//
//  Created by にゃんにゃん丸 on 2021/01/22.
//

import SwiftUI

let gradient = LinearGradient(gradient: .init(colors: [color1,color2]), startPoint: .topTrailing, endPoint: .bottomTrailing)

let color1 =  Color(#colorLiteral(red: 1, green: 0.07007885724, blue: 1, alpha: 1))
let color2 = Color(#colorLiteral(red: 0.2083747387, green: 0.2889660597, blue: 1, alpha: 1))

struct ContentView: View {
    var body: some View {
       Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @Environment(\.colorScheme) var scheme
    
    init() {
        #if os(iOS)
        UITabBar.appearance().isHidden = true
        #endif
    }
    
    @State var selectedtab = "Swift UI"
    var body: some View{
        
        
        ZStack(alignment:self.getDevice() == .iphone ? .bottom : .trailing, content: {
            
            #if os(iOS)
            
            TabView(selection:$selectedtab){
                Color.red
                    .tag("Swift UI")
                    .ignoresSafeArea(.all, edges: .all)
                
                Color.blue
                    .tag("Smile")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                Color.purple
                    .tag("Camera")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                Color.green
                    .tag("Game")
                    .ignoresSafeArea(.all, edges: .all)
                
                
                
            }
            
            #else
            ZStack{
                
                switch(selectedtab){
                
                case "Swift UI" : Color.red
                case "Smile" : Color.red
                case "Camera" : Color.red
                case "Game" : Color.red
                default  : Color.clear
                    
                
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            #endif
            
            if self.getDevice() == .ipad || self.getDevice() == .mac{
                
                VStack{
                    
                    InsideTabButton(selectedtab: $selectedtab)
                    
                    Spacer()
                    
                }
                .background(scheme == .dark ? Color.black : Color.white)
                
            }
            
            
            
            else{
                HStack(spacing:3){
                    
                    InsideTabButton(selectedtab: $selectedtab)
                   
                    
                    
                }
                
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(scheme == .dark ? Color.black : Color.white)
            }
            
        })
        .ignoresSafeArea(.all, edges:self.getDevice() == .iphone ?  .bottom : .trailing)
        .frame(width: self.getDevice() == .ipad || self.getDevice() == .iphone ? nil : getScreeen().width / 1.6, height: self.getDevice() == .ipad || self.getDevice() == .iphone ? nil : getScreeen().height - 150)
       
        
    }
}

struct InsideTabButton : View {
    
    @Binding var selectedtab : String
    var body: some View{
        
        Group{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .padding(.horizontal)
                .padding(.top,getDevice() == .iphone ?  0 : 35)
                .padding(.bottom,getDevice() == .iphone ? 0 : 35)
                
            
            TabButton(title: "Swift UI", image: "swift", selectedtab: $selectedtab)
            
            TabButton(title: "Smile", image: "face.smiling.fill", selectedtab: $selectedtab)
            
            TabButton(title: "Camera", image: "camera", selectedtab: $selectedtab)
            
            TabButton(title: "Game", image: "gamecontroller.fill", selectedtab: $selectedtab)
        }
        
    }
}

struct TabButton : View {
    var title : String
    var image : String
    @Binding var selectedtab : String
    var body: some View{
        Button(action: {
            
            withAnimation(.easeOut){selectedtab = title}
            
        }, label: {
            VStack(spacing:10){
                Image(systemName: image)
                    .font(.system(size:getDevice() == .iphone ? 35 : 25))
                    .foregroundColor(selectedtab == title ? .white : .primary)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(selectedtab == title ? .white : .primary)
                    
                
                
                
                
            }
           
         
            .frame(width:self.getDevice() == .iphone ? (self.getScreeen().width - 75) / 4 : 100, height: 55 + self.getSafeArea())
            .contentShape(Rectangle())
            .background(gradient.offset(x: selectedtab == title ? 0 : getDevice() == .iphone ? 0 : +100, y: selectedtab == title ? 0 : getDevice() == .iphone ? 100 : 0))
           
           
            
           
        })
        .buttonStyle(PlainButtonStyle())
       
       
        
        
        
    }
}

extension View{
    
    func getScreeen() -> CGRect{
        
        #if os(iOS)
        
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
        
        #endif
        
    }
    func getSafeArea() -> CGFloat{
        
        #if os(iOS)
        
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 10
        
        #else
        return 10
        #endif
    }
    
    func getDevice() -> Device{
        
        #if os(iOS)
        
        if UIDevice.current.model.contains("iPad"){
            
            
            return .ipad
        }
        else{
            
            return .iphone
        }
        #else
        return .mac
        
        #endif
        

        
        
    }
    
    
    
}
enum Device{
    
    case iphone
    case ipad
    case mac
    
}
