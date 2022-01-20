//
//  RemindView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 09.01.2022.
//

import SwiftUI

struct RemindView: View {
    // для того чтобы закрывать текущую вьюшку
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //
    @Binding var userSettings: UserSettings
    // чтобы могли использовать эту вьюшку как онбординг
    @Binding var isOnboarding: Bool
    // для того чтобы изменения сохранялись только после нажатия на кнопку save
    @State private var selectedTimeValue = 1.0
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
                .padding(.top)
            
            Text("Remind me each")
                .font(Font.system(size: 36, weight: .semibold))
                .padding(.top, 80)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(MyColor.skyBlue)
                    .frame(height: 330)
                
                timeButtons
                    .onAppear(perform: {
                        // чтобы значение локального state-a был корректным
                        // так как он создается каждый раз, когда открывается эта страница
                        selectedTimeValue = userSettings.selectedTime
                        print("\(Storage.userSettings.selectedTime)")
                    })
                    .padding(.horizontal, 19)
            }
            .padding(.top, 32)
            
            Spacer()
            
            if isOnboarding {
                NavigationLink(destination: DailyIntakeView(userSettings: $userSettings, isOnboarding: $isOnboarding)) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(MyColor.electricBlue)
                            .frame(height: 60)
                        
                        Text("Next")
                            .font(Font.system(size: 22, weight:.semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.bottom)
                }
                .onDisappear(perform: {
                    // перед переходом на следующую страницу онбординга сохраняю изменения
                    userSettings.selectedTime = self.selectedTimeValue
                    Storage.userSettings = userSettings
                    // устанавливаю интервал
                    setNotificationsTimeInterval(userSettings.selectedTime)
                    print(userSettings.selectedTime)
                })
            }
            else {
                CustomButton(title: "Save", action: {
                    // сохраняю изменения
                    userSettings.selectedTime = self.selectedTimeValue
                    Storage.userSettings = userSettings
                    setNotificationsTimeInterval(userSettings.selectedTime)
                    // закрываю вьюшку
                    self.presentationMode.wrappedValue.dismiss()
                    print(userSettings.selectedTime)
                })
                    .padding(.bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.horizontal, 16)
    }
    
    var backButton: some View {
        Button {
            // закрывает текущую вьюшку
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                .frame(width: 30, height: 30)
                .foregroundColor(MyColor.marineBlue)
        }
    }
    
    var notificationsButton: some View {
        Button {
            // настройки local notifications
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
        } label: {
            Image(systemName: "bell")
                .foregroundColor(MyColor.marineBlue)
                .font(.title2)
                .frame(width: 30, height: 30)
        }
    }
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            backButton
            
            Spacer()
            
            Text(isOnboarding ? "WATER BALANCE" : "REMINDER")
                .foregroundColor(MyColor.marineBlue)
                .font(Font.system(size: 17, weight: .black))
                .italic()
            
            Spacer()
            
            notificationsButton
        }
    }
    
    var timeButtons: some View {
        // в структуре сравниваются buttonsValue and selectedTime
        // если они равны то вьюшка выделяется border-ом
        VStack(spacing: 14) {
            HStack(spacing: 14){
                TimeChoiseButton(title: "15 minutes", buttonsValue: 1, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 1
                    }
                
                TimeChoiseButton(title: "30 minutes", buttonsValue: 30, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 30
                    }
            }
            
            HStack(spacing: 14){
                TimeChoiseButton(title: "45 minutes", buttonsValue: 45, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 45
                    }
                TimeChoiseButton(title: "1 hour", buttonsValue: 60, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 60
                    }
            }
            
            HStack(spacing: 14){
                TimeChoiseButton(title: "1,5 hours", buttonsValue: 90, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 90
                    }
                
                TimeChoiseButton(title: "2 hours", buttonsValue: 120, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 120
                    }
            }
            
            HStack(spacing: 14){
                TimeChoiseButton(title: "3 hours", buttonsValue: 180, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 180
                    }
                TimeChoiseButton(title: "4 hours", buttonsValue: 240, selectedTime: $selectedTimeValue)
                    .onTapGesture {
                        self.selectedTimeValue = 240
                    }
            }
        }
        .navigationBarHidden(true)
    }
}

func setNotificationsTimeInterval(_ timeInterval: Double) {
    // удаляю все уведомления чтобы установить новое
    let center = UNUserNotificationCenter.current()
    center.removePendingNotificationRequests(withIdentifiers: ["LocalNotification"])
    center.removeDeliveredNotifications(withIdentifiers: ["LocalNotification"])
    
    let content = UNMutableNotificationContent()
    
    content.title = "WATER BALANCE"
    content.subtitle = "Попей воды"
    content.sound = UNNotificationSound.default
    
    // устанавливаем интервал
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval * 60, repeats: true)
    
    // choose a random identifier
    let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: trigger)
    
    // add our notification request
    UNUserNotificationCenter.current().add(request)
    
    print("time interval: \(trigger.timeInterval)")
}

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        RemindView(userSettings: .constant(UserSettings()), isOnboarding: .constant(false))
    }
}
