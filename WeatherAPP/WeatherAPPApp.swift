//
//  WeatherAPPApp.swift
//  WeatherAPP
//
//  Created by Zuo.Kevin on 2022/7/20.
//

import SwiftUI

@main
struct WeatherAPPApp: App {
    var vm: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
