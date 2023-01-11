//
//  AlarmOn.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 17/06/1444 AH.
//

import SwiftUI

struct AlarmOn: View {
    var body: some View {
        NavigationView{
            
            ZStack{
                Color("back")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Alarm ")
                       // .padding(.horizontal)
                        .foregroundColor(Color("text"))
                        .font(.system(size: 24, weight: .regular, design: .default))
                       // .frame(maxWidth: .infinity, alignment: .top)
                    
                    Button(action: {
                        
                    },label: {
                        
                        //.padding(.horizontal)
                        Text("Snooze")
                        
                            .frame(width:204,height:60)
                            .foregroundColor(Color("text"))
                            .background(Color("sno"))
                            .font(.system(size: 24))
                            .fontWeight(.regular)
                            .background(Color("back"))
                            .cornerRadius(5)
                            .buttonBorderShape(.roundedRectangle)
                            .padding(.vertical, 152.0)
                        
                    }
                           
                    )
                    
                }
            }
            
           
        }
    }
            }
        
struct AlarmOn_Previews: PreviewProvider {
    static var previews: some View {
        AlarmOn()
    }
}
