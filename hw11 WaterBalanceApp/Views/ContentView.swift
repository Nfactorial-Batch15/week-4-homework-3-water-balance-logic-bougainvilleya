//
//  ContentView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 18.01.2022.
//

import SwiftUI

// Onboarding работает, настройки сохраняются
// если выйти из приложения не пройдя до конца онбоардинг, то онбоардинг снова появится

// значение процента не превышает отметку 100%, но значение done может превышать
// дататайм обновляется каждую секунду, поэтому в функции можно просто в форматтере добавить часы
// и он будет корректно отображаться
// текст на main view меняется в зависимости от значения done

// в нампаде нельзя ввести значение больше 4х символов
// если попытаться сохранить с пустым текстфилдом, то есть пустое значение, то в history ничего не добавляется
// значение Daily Intake Level не может быть меньше 100 или же быть пустым

// today yesterday в historyView реализован

// в настройках изменения сохраняются только после нажатия на кнопку Save
// вьюшки в настройках применяются и в онбоардинге, т.е. одна вьюшка как main и как onboarding вместо двух для каждой по отдельности

// интервал 15 минутного ремайндера на самом деле приравняется к 1 минуте (для теста, можно легко поменять в одном месте)

// добавила alert на dailyIntakeView, waterIntakeView

// была совершена попытка скрыть tabbar в subвьюшках, но эта фича мне не понравилась, поэтому убрала

struct ContentView: View {
    // информация о настройках юзера
    @State var userSettings = Storage.userSettings
    @State private var selectedTab: Int = 1
    // флаг для показа онбоардинга
    @State private var isOnboardingFlag = false
    
    var body: some View {
        // главные экраны я покрываю онбордингом и вызываю первый экран онбординга
        TabView(selection: $selectedTab) {
            MainView(userSettings: $userSettings)
            SettingsView(userSettings: $userSettings)
            HistoryView(historyItems: $userSettings.oneDayInformations)
        }
        .fullScreenCover(isPresented: $isOnboardingFlag, content: {
            GoalView(userSettings: $userSettings, isOnboarding: $isOnboardingFlag)
        })
        .onAppear(perform: {
            // после первого вызова я должна сохранить изменения в Storage
            // isOnboarding в UserSettings нужен для передачи значения между страницами онбординга
            isOnboardingFlag = userSettings.isOnboarding
            print(isOnboardingFlag)
            // крашу кнопки табвью на необходимый цвет
            let tabBarAppeareance = UITabBarAppearance()
            tabBarAppeareance.backgroundColor = .white
            UITabBar.appearance().standardAppearance = tabBarAppeareance
        })
        .accentColor(MyColor.electricBlue)
        .ignoresSafeArea()
    }
}
