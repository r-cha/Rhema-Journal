import SwiftUI

struct ResponseView: View {
    @Bindable var promptResponse: PromptResponse

    var body: some View {
        VStack(alignment: .leading) {
            Text(promptResponse.prompt)
                .font(.headline)
                .fixedSize(horizontal: false, vertical: true)
            TextEditor(text: $promptResponse.response)
                .border(Color.gray, width: 0.5)
                .frame(height: 100)
        }
    }
}
