//
//  SettingsView.swift
//  Atlas Weather
//
//  Created by Semih Söğüt on 1.02.2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selected_unit") private var selectedUnit: Unit = .metric
    @AppStorage("selected_timeFormat") private var selectedtimeFormat: TimeFormat = .twentyFourHour
    
    var body: some View {
        NavigationStack {
            List {
                Section (
                    header: Text("title_unitSystem"),
                    footer: Text("description_unitSystem")
                        .multilineTextAlignment(.leading)
                ) {
                    Picker("Unit System", selection: $selectedUnit) {
                        ForEach(Unit.allCases, id: \.self) { mode in
                            Text(mode.displayName)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section (
                    header: Text("title_timeFormat"),
                    footer: Text("description_timeFormat")
                        .multilineTextAlignment(.leading)
                ) {
                    Picker("Time Format", selection: $selectedtimeFormat) {
                        ForEach(TimeFormat.allCases, id: \.self) { mode in
                            Text(mode.displayName)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section ("title_appSettings") {
                    Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                        HStack {
                            Image(systemName: "globe")
                            Text("appSettings_button")
                            Spacer()
                            Image(systemName: "chevron.forward")
                        }
                    }
                }
                
            }
            .navigationTitle("title_settings")
            .presentationDragIndicator(.visible)
            
        }
    }
}

#Preview {
    SettingsView()
}
