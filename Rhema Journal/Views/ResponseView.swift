import SwiftUI


struct ResponseView: View {
    @Bindable var promptResponse: PromptResponse

    var body: some View {
        VStack(alignment: .leading, spacing:10) {
            Text(promptResponse.prompt)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            TextEditor(text: $promptResponse.response)
                .border(Color.gray, width: 0.5)
                .frame(height: 100)
        }
    }
}
