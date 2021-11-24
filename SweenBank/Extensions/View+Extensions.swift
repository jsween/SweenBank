//
//  View+Extensions.swift
//  SweenBank
//
//  Created by Jonathan Sweeney on 11/24/21.
//

import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
