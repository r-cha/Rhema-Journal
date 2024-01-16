//
//  IconSetter.swift
//  Rhema Journal
//
//  Created by Robert Chandler on 1/16/24.
//
import Foundation
import SwiftUI

enum AppIcon: String, CaseIterable, Identifiable {
    case primary = "AppIcon"
    case lightMode = "AppIcon-Light"
    
    var id: String { rawValue }
    var iconName: String? {
        switch self {
        case .primary:
            /// `nil` is used to reset the app icon back to its primary icon.
            return nil
        default:
            return rawValue
        }
    }
    
    var description: String {
        switch self {
        case .primary:
            return "Dark"
        case .lightMode:
            return "Light"
        }
    }
    
    var preview: UIImage {
        UIImage(named: rawValue) ?? UIImage()
    }
}

final class ChangeAppIconViewModel: ObservableObject {
    @Published private(set) var selectedAppIcon: AppIcon
    
    init() {
        if let iconName = UIApplication.shared.alternateIconName, let appIcon = AppIcon(rawValue: iconName) {
            selectedAppIcon = appIcon
        } else {
            selectedAppIcon = .primary
        }
    }
    
    func updateAppIcon(to icon: AppIcon) {
        let previousAppIcon = selectedAppIcon
        selectedAppIcon = icon
        
        Task { @MainActor in
            guard UIApplication.shared.alternateIconName != icon.iconName else {
                /// No need to update since we're already using this icon.
                return
            }
            
            do {
                try await UIApplication.shared.setAlternateIconName(icon.iconName)
            } catch {
                /// We're only logging the error here and not actively handling the app icon failure
                /// since it's very unlikely to fail.
                print("Updating icon to \(String(describing: icon.iconName)) failed.")
                
                /// Restore previous app icon
                selectedAppIcon = previousAppIcon
            }
        }
    }
}

struct CheckboxView: View {
    let isSelected: Bool
    
    private var image: UIImage {
        let imageName = isSelected ? "icon-checked" : "icon-unchecked"
        return UIImage(imageLiteralResourceName: imageName)
    }
    
    var body: some View {
        Image(uiImage: image)
    }
}

struct IconSetter: View {
    @StateObject var viewModel = ChangeAppIconViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("App Icon").font(.headline)
            HStack(alignment: .center) {
                HStack {Spacer()}
                ForEach(AppIcon.allCases) { appIcon in
                    VStack(alignment: .center) {
                        Image(uiImage: appIcon.preview)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .cornerRadius(12)
                        Text(appIcon.description)
                            .font(.caption)
//                        CheckboxView(isSelected: viewModel.selectedAppIcon == appIcon)
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            viewModel.updateAppIcon(to: appIcon)
                        }
                    }
                }
            }
            .padding()
            .background(.ultraThinMaterial, in: RoundedRectangle(
                cornerRadius: 8, style: .continuous
            ))
        }
    }
}

#Preview {
    IconSetter()
}
