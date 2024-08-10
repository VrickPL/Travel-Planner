//
//  SettingsView.swift
//  TravelPlanner
//
//  Created by Jan Kazubski on 10/08/2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(Keys.SELECTED_LANGUAGE) private var selectedLanguage:
        Language = Language.systemDefault
    @AppStorage(Keys.SELECTED_THEME) private var selectedTheme:
        Theme = Theme.systemDefault

    @Environment(\.colorScheme) var systemColorScheme

    var body: some View {
        NavigationView {
            Form {
                generalSection

                authorSection
            }
        }
        .environment(\.locale, selectedLanguage.locale)
        .environment(\.colorScheme, selectedColorScheme)
    }
    
    private var selectedColorScheme: ColorScheme {
        return selectedTheme.colorScheme ?? systemColorScheme
    }

    private var generalSection: some View {
        Section(header: Text("general")) {
            HStack {
                SettingsIcon(systemName: "globe", backgroundColor: .blue)

                Picker("language", selection: $selectedLanguage) {
                    ForEach(Language.allCases, id: \.rawValue) { language in
                        Text(LocalizedStringKey(language.rawValue)).tag(
                            language)
                    }
                }
            }
            HStack {
                SettingsIcon(systemName: "moon", backgroundColor: .gray)

                Picker("theme", selection: $selectedTheme) {
                    ForEach(Theme.allCases, id: \.rawValue) { theme in
                        Text(LocalizedStringKey(theme.rawValue)).tag(theme)
                    }
                }
            }
        }
    }

    private var authorSection: some View {
        Section(
            header: HStack {
                Text("app_author")
                Text("-  Jan Kazubski")
            }
        ) {
            LinkButton(url: "https://github.com/VrickPL", title: "GitHub")
            LinkButton(
                url: "https://linkedin.com/in/jan-kazubski", title: "LinkedIn")
        }
    }
    
    private struct SettingsIcon: View {
        var systemName: String
        var backgroundColor: Color
        
        var body: some View {
            Image(systemName: systemName)
                .foregroundColor(.white)
                .padding(3)
                .background(backgroundColor)
                .cornerRadius(5)
        }
    }

    private struct LinkButton: View {
        let url: String
        let title: String

        var body: some View {
            Button(action: openURL) {
                HStack {
                    Image(systemName: "link")
                    Text(title)
                }
            }
        }

        private func openURL() {
            guard let url = URL(string: url) else { return }
            UIApplication.shared.open(url)
        }
    }
}

#Preview {
    SettingsView()
}
