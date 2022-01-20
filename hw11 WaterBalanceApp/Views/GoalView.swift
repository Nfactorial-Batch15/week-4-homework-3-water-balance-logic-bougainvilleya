//
//  GoalView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 09.01.2022.
//

import SwiftUI

struct GoalView: View {
    // для кастомного баттона чтобы закрывать вьюшку
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    //
    @Binding var userSettings: UserSettings
    // для того чтобы могли использовать вьюшку как онбординг, так и как обычную вьюшку
    @Binding var isOnboarding: Bool
    // изначально выбор тайма тоже был реализован на массиве
    // но он мне показался плохим, поэтому сделала по другому
    // для сохранения выбранного goal-a
    @State private var selectedGoal = [false, false, false, false]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                navigationBar
                    .padding(.top)
                
                Text("What is your goal?")
                    .font(Font.system(size: 36, weight: .semibold))
                    .padding(.bottom, 32)
                    .padding(.top, 80)
                    .onAppear {
                        self.selectedGoal = userSettings.selectedGoal
                    }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(MyColor.skyBlue)
                        .frame(height: 330)
                    
                    VStack(spacing: 14) {
                        GoalChoiceButton(isSelected: $selectedGoal[0], title: "Goal number One")
                            .onTapGesture {
                                self.selectedGoal = [true, false, false, false]
                            }
                        GoalChoiceButton(isSelected: $selectedGoal[1], title: "Goal number Two")
                            .onTapGesture {
                                self.selectedGoal = [false, true, false, false]
                            }
                        GoalChoiceButton(isSelected: $selectedGoal[2], title: "Goal number Three")
                            .onTapGesture {
                                self.selectedGoal = [false, false, true, false]
                            }
                        GoalChoiceButton(isSelected: $selectedGoal[3], title: "Goal number Four")
                            .onTapGesture {
                                self.selectedGoal = [false, false, false, true]
                            }
                    }
                }
                
                Spacer()
                if isOnboarding {
                    NavigationLink(destination: RemindView(userSettings: $userSettings, isOnboarding: $isOnboarding)) {
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
                        // сохранить изменения
                        userSettings.selectedGoal = self.selectedGoal
                        Storage.userSettings = userSettings
                        print(userSettings.selectedGoal)
                    })
                }
                else {
                    CustomButton(title: "Save", action: {
                        // сохранить изменения и закрыть вьюшку
                        userSettings.selectedGoal = self.selectedGoal
                        Storage.userSettings = userSettings
                        self.presentationMode.wrappedValue.dismiss()
                    })
                        .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
            .padding(.horizontal, 16)
        }
        .navigationBarHidden(true)
    }
    
    var backButton: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(MyColor.marineBlue)
        }
    }
    
    var navigationBar: some View {
        HStack(spacing: 0) {
            if !isOnboarding {
                backButton
            }
            Spacer()
            Text(isOnboarding ? "WATER BALANCE" : "THE GOAL")
                .foregroundColor(MyColor.marineBlue)
                .font(Font.system(size: 17, weight: .black))
                .italic()
            Spacer()
            // change to geometry reader
            if !isOnboarding {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .opacity(0)
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GoalView(userSettings: .constant(UserSettings()), isOnboarding: .constant(false))
        }
    }
}
