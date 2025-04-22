//
//  TimePicker.swift
//  FRCalendar
//
//  Created by Enrique Haro Márquez on 2025-04-16.
//

import SwiftUI

struct TimePicker: View {
    @Binding var type: System

    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var timeRange: Int
    
    @State var yearRange: Range<Int> = 1..<335
    @State var monthRange: Range<Int> = 1..<14
    @State var dayRange: Range<Int> = 1..<31
    

    var body: some View {
        HStack(spacing: 0.0) {
            Picker(selection: $hour, label: Text("Picker"), content: {
                ForEach(type == .decimal ? (0..<10) : (1..<13), id: \.self) { hIndex in
                    Text("\(hIndex.padded)").tag(hIndex)
                }
            })
            .padding(.trailing, -15.0)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            
            Picker(selection: $minute, label: Text("Picker"), content: {
                ForEach(0..<(type == .decimal ? 100 : 60), id: \.self) { mIndex in
                    if mIndex % 5 == 0 {
                        Text("\(mIndex.padded)").tag(mIndex)
                    }
                }
            })
            .frame(minWidth: 175.0)
            .padding(.horizontal, -15.0)
            .pickerStyle(WheelPickerStyle())
            .clipped()
            
            if type != .decimal {
                Picker(selection: $timeRange, label: Text("Picker"), content: {
                    ForEach(0..<2, id: \.self) { dayHalf in
                        Text(dayHalf == 0 ? "AM" : "PM").tag(dayHalf)
                    }
                })
                .padding(.leading, -15.0)
                .pickerStyle(WheelPickerStyle())
                .clipped()
            }
        }
    }

    enum System {
        case decimal, standard
    }
}


