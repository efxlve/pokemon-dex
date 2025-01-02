//
//  Dex3WidgetBundle.swift
//  Dex3Widget
//
//  Created by Muharrem Efe Çayırbahçe on 1.01.2025.
//

import WidgetKit
import SwiftUI

@main
struct Dex3WidgetBundle: WidgetBundle {
    var body: some Widget {
        Dex3Widget()
        Dex3WidgetControl()
        Dex3WidgetLiveActivity()
    }
}
