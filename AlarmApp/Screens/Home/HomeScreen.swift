//
//  HomeScreen.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 16/06/1444 AH.
//

import SwiftUI

struct HomeScreen: View {
    @State private var showAlarmDetail: Bool = false
    @State var selection = Set<String>()
    @State var names: [Date] = [Date()]
    var body: some View {
        NavigationView {
            
            VStack {
                VStack(alignment: .leading) {
                    dateLabel
                    
                    
                    
                }
                .padding(.horizontal)
                
                if names.count == 0 {
                    VStack {
                        Text("No Alarms")
                        
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                            .padding(.trailing)
                            .padding(20)
                        .foregroundColor(Color("text"))
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 360,height: 1)
                            .foregroundColor(Color("text"))
                    }
                } else {
                    List(names, id: \.self, selection: $selection) { name in
                        VStack {
                            Rectangle()
                                .foregroundColor(Color("circle"))
                                .frame(height: 80)
                                .padding(.top)
                                .overlay {
                                    Text("name")
                                }
                            Toggle("User has been contacted",isOn: .constant(true))
                                .toggleStyle(CheckToggleStyle())
                            Toggle("", isOn: .constant(true))
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    }
                    
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    .foregroundColor(Color("text"))
                    .padding(.top)
                    .padding(.horizontal)
                }
                    
                    
            }
            .navigationTitle(Text("Alarm"))
            .sheet(isPresented: $showAlarmDetail, content: {
                AlarmDetailScreen(names: $names)
            })
//            .tint(Color("text"))
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    plusButton
                        .foregroundColor(Color("text"))
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    editButton
                        .foregroundColor(Color("text"))
                        
                }
                
            }
//            .toolbarBackground(
//                Color.white.opacity(0.001),
//                            for: .navigationBar)
//            .toolbarColorScheme(.dark, for: .navigationBar)
//            .toolbarBackground(.hidden, for: .navigationBar)
            .background(Color("back"))
        }

    }
    
    
    @ViewBuilder
    private var dateLabel: some View {
        Text(dateString)
            .font(.system(size: 24, weight: .regular, design: .default))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color("text"))
        
    }
    
    private var plusButton: some View {
        Button {
            showAlarmDetail = true
        } label: {
            Image(systemName: "plus")
        }
        
    }
    
    private var editButton: some View {
        Button {
            // handle tap plus
        } label: {
            Text("Edit")
        }
        
    }
    
    private var dateString: String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE,d MMM"
        return formatter.string(from: currentDate)
        
    }
    
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
