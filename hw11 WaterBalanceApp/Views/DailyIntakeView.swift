//
//  DailyIntakeView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 09.01.2022.
//

import SwiftUI

struct DailyIntakeView: View {
    // нужен для backButton чтобы закрывать текущую вьюшку
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // для онбоардинга
    @State private var isPresented = false
    // локальный var для того чтобы значение сохранялось только с помощью кнопки Save
    @State private var inputTotalValue = "1000"
    // для показа алерта
    @State private var isHiddenAlert = true
    // для клавиатуры (чтобы закрывался при нажатии на кнопку Save)
    @FocusState private var isFocused: Bool
    //
    @Binding var userSettings: UserSettings
    //
    @Binding var isOnboarding: Bool
    // чтобы при вводе неправильных данных устанавливать дефолтное значение
    let defaultDailyIntakeLevel = "1000"
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                navigationBar
                    .padding(.top)
                
                Text("Daily intake")
                    .font(Font.system(size: 36, weight: .medium))
                    .padding(.top, 122)
                    .onAppear {
                        // проверяем введенное значение на корректность
                        checkInputValue(&inputTotalValue)
                    }
                
                customTextField
                    .padding(.top, 32)
                
                Spacer()
                
                // если эта вьюшка онбоардинг
                if isOnboarding {
                    CustomButton(title: "Save") {
                        // то сперва меняем значение onBoarding
                        // чтобы онбоардинг больше не отображался
                        userSettings.isOnboarding = false
                        isOnboarding = false
                        // сохраняем изменения в Storage
                        userSettings.total = inputTotalValue
                        Storage.userSettings = userSettings
                        // закрываем онбоардинг
                        isPresented.toggle()
                    }
                    .padding(.bottom)
                }
                else {
                    CustomButton(title: "Save", action: {
                        // закрываем клавиатуру
                        isFocused = false
                        withAnimation {
                            // показываем алерт
                            isHiddenAlert = false
                            // через 2 секунды скрываем алерт
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isHiddenAlert = true
                            }
                        }
                    })
                    .padding(.bottom)
                }
            }
            .blur(radius: isHiddenAlert ? 0 : 1)
            
            CustomAlert(isHidden: $isHiddenAlert)
        }
        .navigationBarHidden(true)
        .padding(.horizontal, 16)
    }
    
    var backButton: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(MyColor.marineBlue)
        }
    }
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            backButton
            Spacer()
            Text("WATER BALANCE")
                .foregroundColor(MyColor.marineBlue)
                .font(Font.system(size: 17, weight: .black))
                .italic()
            
            Spacer()
            
            Image(systemName: "chevron.left")
                .font(.title2)
                .opacity(0)
        }
    }
    
    var customTextField: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(MyColor.skyBlue)
                .frame(height: 108)
            
            HStack(spacing: 12){
                TextField("2500", text: $inputTotalValue)
                    .textFieldStyle(CustomTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 19)
                    .focused($isFocused)
                    .onReceive(inputTotalValue.publisher.collect()) {
                        // количество символов введенного значения не должно превышать 4
                        inputTotalValue = String($0.prefix(4))
                    }
                
                Text("ML")
                    .font(Font.system(size: 16))
                    .padding(.trailing, 43)
            }
        }
    }
    

    func checkInputValue(_ inputValue: inout String) {
        // проверяю и сохраняю введенные значения
        // поле не пустое и введенное значение ок
        if let value = Int(inputValue) {
            // если значение меньше 100
            if value < 100 {
                // устанавливаем дефолтное значение
                inputValue = defaultDailyIntakeLevel
            }
        }
        else {
            // если поле пустое то устанавливаю дефолтное значение
            inputValue = defaultDailyIntakeLevel
        }
        // беру значение локального state-a и сохраняю изменения в userSettings и Storage
        print("total value: \(inputValue)")
        userSettings.total = inputValue
        Storage.userSettings = userSettings
    }
}

func isToday(_ date: Date) -> Bool {
    // для проверки даты последнего элемента массива
    let componentsToday = Calendar.current.dateComponents([.day, .month, .year], from: Date())
    let componentsDate = Calendar.current.dateComponents([.day, .month, .year], from: date)
    return componentsToday == componentsDate
}

struct DailyIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        DailyIntakeView(userSettings: .constant(UserSettings()), isOnboarding: .constant(false))
    }
}
