//
//  LockScreenWidgetsBundle.swift
//  LockScreenWidgets
//
//  Created by 相川真司 on 2023/04/10.
//

import WidgetKit
import SwiftUI

@main
struct LockScreenWidgetsBundle: WidgetBundle {
    var body: some Widget {
        LockScreenWidgets()
        LockScreenWidgetsLiveActivity()
    }
}
