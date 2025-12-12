//
//  Settings.swift
//  BookManager
//
//  Created by Wendell Richards on 12/11/25.
//

import SwiftUI

struct Settings: View {
    @AppStorage("SETTINGS_THEME") private var selectedTheme: Theme = .system
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")){
                    Picker("Theme", selection: $selectedTheme){
                        ForEach(Theme.allCases, id: \.self) { theme in
                            Text(theme.rawValue.capitalized).tag(theme)
                        }
                    }
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}
