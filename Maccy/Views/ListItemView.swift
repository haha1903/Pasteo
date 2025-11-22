import Defaults
import SwiftUI

struct ListItemView<Title: View>: View {
  var id: UUID
  var appIcon: ApplicationImage?
  var image: NSImage?
  var accessoryImage: NSImage?
  var attributedTitle: AttributedString?
  var shortcuts: [KeyShortcut]
  var isSelected: Bool
  var help: LocalizedStringKey?
  @ViewBuilder var title: () -> Title

  @Default(.showApplicationIcons) private var showIcons
  @Environment(AppState.self) private var appState
  @Environment(ModifierFlags.self) private var modifierFlags

  var body: some View {
    HStack(spacing: 0) {
      if showIcons, let appIcon {
        VStack {
          Spacer(minLength: 0)
          Image(nsImage: appIcon.nsImage)
            .resizable()
            .frame(width: 16, height: 16)
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 0.5)
          Spacer(minLength: 0)
        }
        .padding(.leading, 8)
        .padding(.vertical, 6)
      }

      Spacer()
        .frame(width: showIcons ? 8 : 12)

      if let accessoryImage {
        Image(nsImage: accessoryImage)
          .accessibilityIdentifier("copy-history-item")
          .padding(.trailing, 8)
          .padding(.vertical, 6)
      }

      if let image {
        Image(nsImage: image)
          .accessibilityIdentifier("copy-history-item")
          .padding(.trailing, 8)
          .padding(.vertical, 6)
          .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
      } else {
        ListItemTitleView(attributedTitle: attributedTitle, title: title)
          .padding(.trailing, 8)
      }

      Spacer()

      if !shortcuts.isEmpty {
        ZStack {
          ForEach(shortcuts) { shortcut in
            KeyboardShortcutView(shortcut: shortcut)
              .opacity(shortcut.isVisible(shortcuts, modifierFlags.flags) ? 1 : 0)
          }
        }
        .padding(.trailing, 12)
      } else {
        Spacer()
          .frame(width: 50)
      }
    }
    .frame(minHeight: Popup.itemHeight + 4)
    .id(id)
    .frame(maxWidth: .infinity, alignment: .leading)
    .foregroundStyle(isSelected ? Color.white : .primary)
    .background(
      ZStack {
        if isSelected {
          // Vibrant gradient background for selected state
          RoundedRectangle(cornerRadius: Popup.cornerRadius + 1, style: .continuous)
            .fill(
              LinearGradient(
                colors: [
                  Color.accentColor,
                  Color.accentColor.opacity(0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
              )
            )
            .overlay(
              LinearGradient(
                colors: [
                  Color.white.opacity(0.25),
                  Color.clear
                ],
                startPoint: .top,
                endPoint: .center
              )
            )
            .shadow(color: Color.accentColor.opacity(0.4), radius: 6, x: 0, y: 3)
            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 1)
        } else {
          // Transparent background for seamless appearance
          Color.clear
        }
      }
    )
    .clipShape(RoundedRectangle(cornerRadius: Popup.cornerRadius + 1, style: .continuous))
    .scaleEffect(isSelected ? 1.01 : 1.0)
    .animation(.spring(response: 0.25, dampingFraction: 0.8), value: isSelected)
    .onHover { hovering in
      if hovering {
        if !appState.isKeyboardNavigating {
          appState.selectWithoutScrolling(id)
        } else {
          appState.hoverSelectionWhileKeyboardNavigating = id
        }
      }
    }
    .help(help ?? "")
  }
}
