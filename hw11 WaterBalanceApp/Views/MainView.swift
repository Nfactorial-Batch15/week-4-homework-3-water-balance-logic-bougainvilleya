//
//  MainView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 09.01.2022.
//

import SwiftUI

struct MainView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var date = CurrentDateTime()
    @Binding var userSettings: UserSettings
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("WATER BALANCE")
                    .font(Font.system(size: 17, weight: .black))
                    .italic()
                    .foregroundColor(MyColor.marineBlue)
                    .padding(.bottom, 30)
                    .padding(.top)
                
                ZStack {
                    backgroundRectangle
                    
                    VStack(spacing: 0) {
                        progressBar
                            .padding(.bottom, 58)
                        currentDateTime
                    }
                }
                
                // если количество выпитой воды равна нулю ->
                Text(userSettings.done == 0 ? "Add your first drink for today" : "Great job!")
                    .font(Font.system(size: 36, weight: .semibold))
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Spacer()
                
                NavigationLink(destination: WaterIntakeView(userSettings: $userSettings)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(MyColor.electricBlue)
                            .frame(height: 60)
                        
                        Text("Add")
                            .font(Font.system(size: 22, weight:.semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 125)
                    .padding(.bottom)
                }
                
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 16)
        }
        .tabItem{
            Label("Main", systemImage: "house")
        }
        .tag(1)
    }
    
    var progressBar: some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 4)
                .frame(width: 180, height: 180)
            
            Circle()
                .fill(MyColor.skyBlue)
                .frame(width: 160, height: 160)
            
            ProgressInformation(userSettings: $userSettings)
                .onAppear {
                    // чтобы обновлять userSettings, а именно done
                    
                    // если история пустая или дата последнего элемента в списке
                    // не совпадает с текущей датой, то обновляем значение done
                    // а так же сохраняем изменения в Storage
                    if userSettings.oneDayInformations.isEmpty || !isToday(userSettings.oneDayInformations.last?.date ?? Date()) {
                        userSettings.done = 0
                        Storage.userSettings = userSettings
                    }
                }
        }
    }
    
    var currentDateTime: some View {
        Text("\(date.weekDay), \(date.day)\(date.ordinal) \(date.month)")
            .font(Font.system(size: 17, weight: .light))
            .onReceive(timer) { _ in
                // обновляю таймер каждую секунду
                // можно отображать и секунды с минутами, будет работать корректно
                date.updateDateTime()
            }
    }
    
    var backgroundRectangle: some View{
        RoundedRectangle(cornerRadius: 16)
            .fill(
                LinearGradient(gradient: Gradient(colors: [.white, MyColor.skyBlue]),
                               startPoint: .bottom,
                               endPoint: .top))
            .frame(height: 330)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(userSettings: .constant(UserSettings()))
    }
}
