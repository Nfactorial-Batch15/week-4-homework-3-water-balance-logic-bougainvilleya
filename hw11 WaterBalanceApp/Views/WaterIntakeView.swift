//
//  WaterIntakeView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 16.01.2022.
//

import SwiftUI

struct WaterIntakeView: View {
    // для того чтобы закрывать эту вьюшку через backButton
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // для того чтобы открывать/закрывать клавиатуру
    @FocusState private var isFocused: Bool
    // тут вносятся изменения для userSettings.oneCupOfWater
    @Binding var userSettings: UserSettings
    // для показа алерта
    @State private var isHiddenAlert = true
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                navigationBar
                    .padding(.top)
                
                Text("Water intake")
                    .font(Font.system(size: 36, weight: .medium))
                    .padding(.top, 122)
                
                customTextField
                    .padding(.top, 32)
                
                Spacer()
                
                addButton
                    .padding(.bottom)
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 16)
            .blur(radius: isHiddenAlert ? 0 : 1)
            
            CustomAlert(isHidden: $isHiddenAlert)
        }
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
            
            Text("WATER")
                .foregroundColor(MyColor.marineBlue)
                .font(Font.system(size: 17, weight: .black))
                .italic()
            
            Spacer()
            // change to geometry reader
            // просто для того чтобы тайтл находился в центре
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
                TextField("200", text: $userSettings.oneCupOfWater)
                    .textFieldStyle(CustomTextFieldStyle())
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.center)
                    .padding(.leading, 19)
                    .focused($isFocused)
                    .onReceive(userSettings.oneCupOfWater.publisher.collect()) {
                        // для того чтобы пользователь не вводил значения больше 4-х символов
                        userSettings.oneCupOfWater = String($0.prefix(4))
                        // изменения сохраняю в UserDefaults
                        Storage.userSettings = userSettings
                    }
                
                Text("ML")
                    .font(Font.system(size: 16))
                    .padding(.trailing, 43)
            }
        }
    }
    
    var addButton: some View {
        CustomButton(title: "Add") {
            // увеличиваем количество выпитой воды
            if (Int(userSettings.oneCupOfWater) ?? 0) != 0 {
                userSettings.done = userSettings.done + (Int(userSettings.oneCupOfWater) ?? 0)
                
                // дальше записываем в history
                // если наш history пустой или же дата последнего элемента в history
                // не совпадает с текущей датой
                // добавляем новый элемент в наш массив для хранения history
                if userSettings.oneDayInformations.isEmpty ||
                    !isToday(userSettings.oneDayInformations.last?.date ?? Date()) {
                    userSettings.oneDayInformations.append(OneDayInformation(date: Date(),
                                                                             intakeItems: []))
                }
                
                // дальше уже добавляем информацию о выпитом стакане воды в массив последнего элемента массива history
                userSettings.oneDayInformations[
                    userSettings.oneDayInformations.count - 1]
                    .intakeItems.append(IntakeItem(
                        time: Date(), amount: Int(userSettings.oneCupOfWater) ?? 0))
                
                withAnimation {
                    // показываем алерт
                    isHiddenAlert = false
                    // через 2 секунды скрываем алерт
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isHiddenAlert = true
                    }
                }
                
                // обновляю хранилище
                Storage.userSettings = userSettings
                // закрываю клавиатуру
                isFocused = false
            }
        }
    }
}

struct WaterIntakeView_Previews: PreviewProvider {
    static var previews: some View {
        WaterIntakeView(userSettings: .constant(UserSettings()))
    }
}
