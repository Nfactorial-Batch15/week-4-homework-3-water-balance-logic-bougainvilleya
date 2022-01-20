//
//  SettingsView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 09.01.2022.
//

import SwiftUI

struct SettingsView: View {
    @Binding var userSettings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("EDIT")
                    .font(Font.system(size: 17, weight: .black))
                    .italic()
                    .foregroundColor(MyColor.marineBlue)
                    .padding(.bottom, 30)
                    .padding(.top)
                
                Group {
                    toDailyIntakeView
                    toGoalView
                    toReminderView
                }
                .padding(.top, 41)
                
                
                Spacer()
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 16)
        }
        .tabItem {
            Label("Settings", systemImage: "gear")
        }
        .tag(2)
    }
    
    
    var toGoalView: some View {
        NavigationLink(destination: GoalView(userSettings: $userSettings, isOnboarding: .constant(false))) {
            HStack {
                Text("Your goal")
                    .font(Font.system(size: 17))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
    
    var toDailyIntakeView: some View {
        NavigationLink(destination: DailyIntakeView(userSettings: $userSettings, isOnboarding: .constant(false))) {
            HStack {
                Text("Daily Intake Level")
                    .font(Font.system(size: 17))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(userSettings.total) ML")
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .foregroundColor(.gray)
        }
    }
    
    var toReminderView: some View {
        NavigationLink(destination: RemindView(userSettings: $userSettings, isOnboarding: .constant(false))) {
            HStack {
                Text("Reminder")
                    .font(Font.system(size: 17))
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(userSettings: .constant(UserSettings()))
    }
}
