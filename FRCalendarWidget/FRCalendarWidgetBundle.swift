//
//  FRCalendarWidgetBundle.swift
//  FRCalendarWidget
//
//  Created by Enrique Haro Márquez on 2025-04-22.
//

import WidgetKit
import SwiftUI

@main
struct FRCalendarWidgetBundle: WidgetBundle {
    
    var body: some Widget {
        FRCalendarWidget()
        MonthGridWidget()
        InlineDateWidget()
        AccesoryDateWidget()
    }
}
