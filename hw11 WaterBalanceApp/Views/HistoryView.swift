//
//  HistoryView.swift
//  hw11 WaterBalanceApp
//
//  Created by Leyla Nyssanbayeva on 09.01.2022.
//

import SwiftUI

struct HistoryView: View {
    @Binding var historyItems: [OneDayInformation]
    
    var body: some View {
        VStack(spacing: 0) {
            Text("HISTORY")
                .font(Font.system(size: 17, weight: .black))
                .italic()
                .foregroundColor(MyColor.marineBlue)
                .padding(.bottom, 30)
                .padding(.top)
            
            List {
                // проходимся по каждому дню
                ForEach(historyItems.reversed(), id: \.id) { historyItem in
                    Section {
                        // проходимся по каждому элементу определенного дня
                        ForEach(historyItem.intakeItems.reversed(), id: \.id) { intakeItem in
                            HStack {
                                Text("\(intakeItem.amount) ml")
                                Spacer()
                                let timeText = formattedTime(for: intakeItem.time)
                                Text(timeText)
                                    .foregroundColor(MyColor.systemGray)
                                    .opacity(0.6)
                            }
                            .padding(.top, 8)
                        }
                    } header: {
                        Text(formattedDate(for: historyItem.date))
                            .font(Font.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    .listRowInsets(.none)
                }
                .padding(.top)
            }
            .listRowInsets(.none)
            .listStyle(.inset)
            .animation(.easeInOut)
            
            Spacer()
        }
        .tabItem{
            Label("History", systemImage: "doc")
        }
        .tag(2)
    }
    
    func formattedDate(for date: Date) -> String {
        // берем текущую дату
        let componentsToday = Calendar.current.dateComponents([.day, .month, .year], from: Date())
        // берем дату последнего элемента в списке
        let componentsLastItem = Calendar.current.dateComponents([.day, .month, .year], from: date)
        // берем вчерашнюю дату
        let componentsYesterday = Calendar.current.dateComponents([.day, .month, .year], from: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date())
        
        // сравниваем
        if componentsToday == componentsLastItem {
            return "Today"
        }
        if componentsYesterday == componentsLastItem {
            return "Yesterday"
        }
        
        // форматируем
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        return formatter.string(from: date)
    }
    
    
    func formattedTime(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(historyItems: .constant([]))
    }
}
