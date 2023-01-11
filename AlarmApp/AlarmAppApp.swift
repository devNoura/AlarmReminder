//
//  AlarmAppApp.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 16/06/1444 AH.
//

import SwiftUI

@main
struct AlarmAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .onAppear {
                    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(named: "text")!]
                    
                    //Use this if NavigationBarTitle is with displayMode = .inline
                    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "text")!]
                }
                .preferredColorScheme(.dark)
        }
    }
}
