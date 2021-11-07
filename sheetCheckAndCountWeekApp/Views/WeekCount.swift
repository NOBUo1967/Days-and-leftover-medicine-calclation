//
//  WeekCount.swift
//  sheetCheckAndCountWeekApp
//
//  Created by Shinichiro Hirasawa on 2021/10/18.
//

import SwiftUI

struct WeekCount: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var dateFormat: DateFormatter {
            let format = DateFormatter()
            format.dateStyle = .full
            format.timeStyle = .full
            format.locale = Locale(identifier: "ja_JP")
            format.calendar = Calendar(identifier: .japanese)
            format.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMdd", options: 0, locale: Locale(identifier: "ja_JP"))
            return format
        }
    
    
    var body: some View {
        Form {
            DatePicker("開始日", selection: $startDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
            DatePicker("終了日", selection: $endDate, displayedComponents: .date)
                .environment(\.locale, Locale(identifier: "ja_JP"))
            
            Text("\(startDate, formatter: dateFormat)から\(endDate, formatter: dateFormat)は\(calclateSpan(startDate: self.startDate, endDate: self.endDate))日")
        } // Form
    } // body
    
    // 指定した日付の時間をリセットする関数
    func resetTime(date: Date) -> Date {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components)!
    }
    
    // 日付の差を計算する関数
    func calclateSpan(startDate: Date, endDate: Date) -> Int {
        let resetTimeStartDate = resetTime(date: startDate)
        let resteTImeEndDate = resetTime(date: endDate)
        
        // 計算部分 TimeIntervalがDouble型のため差spanはDouble型で宣言
        let span:Double = resteTImeEndDate.timeIntervalSince(resetTimeStartDate)
        // TimeIntervalが秒数で与えられるため(60秒*60分*24時間)で除算して日数へ変換
        let differenceInTheNumberOfDays = span/(60*60*24)
        
        return Int(differenceInTheNumberOfDays)
    }
}

struct WeekCount_Previews: PreviewProvider {
    static var previews: some View {
        WeekCount()
    }
}
