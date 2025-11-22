import SwiftUI

struct SearchFieldView: View {
  var placeholder: LocalizedStringKey
  @Binding var query: String

  @Environment(AppState.self) private var appState
  @State private var isFocused: Bool = false

  var body: some View {
    ZStack {
      // Brighter background with vibrant gradient and shadow
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .fill(
          LinearGradient(
            colors: [
              Color.white.opacity(0.35),
              Color.white.opacity(0.25)
            ],
            startPoint: .top,
            endPoint: .bottom
          )
        )
        .overlay(
          RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(
              LinearGradient(
                colors: [
                  Color.white.opacity(isFocused ? 0.5 : 0.35),
                  Color.blue.opacity(isFocused ? 0.2 : 0.0)
                ],
                startPoint: .top,
                endPoint: .bottom
              ),
              lineWidth: 1.5
            )
        )
        .shadow(color: Color.blue.opacity(isFocused ? 0.15 : 0.08), radius: 4, x: 0, y: 2)
        .shadow(color: Color.black.opacity(0.08), radius: 1, x: 0, y: 1)
        .frame(height: 28)

      HStack(spacing: 6) {
        Image(systemName: "magnifyingglass")
          .font(.system(size: 12, weight: .medium))
          .foregroundStyle(.blue.opacity(0.8))
          .padding(.leading, 10)

        TextField(placeholder, text: $query)
          .disableAutocorrection(true)
          .lineLimit(1)
          .textFieldStyle(.plain)
          .font(.system(size: 13))
          .onSubmit {
            appState.select()
          }

        if !query.isEmpty {
          Button {
            withAnimation(.easeInOut(duration: 0.15)) {
              query = ""
            }
          } label: {
            Image(systemName: "xmark.circle.fill")
              .font(.system(size: 12))
              .foregroundStyle(.blue.opacity(0.7))
              .padding(.trailing, 10)
          }
          .buttonStyle(PlainButtonStyle())
          .transition(.scale.combined(with: .opacity))
        }
      }
    }
    .animation(.easeInOut(duration: 0.2), value: query.isEmpty)
  }
}

#Preview {
  return List {
    SearchFieldView(placeholder: "search_placeholder", query: .constant(""))
    SearchFieldView(placeholder: "search_placeholder", query: .constant("search"))
  }
  .frame(width: 300)
  .environment(\.locale, .init(identifier: "en"))
}
