import SwiftUI


struct ResponseView: View {
    var promptResponse: PromptResponse
    @State private var response: String
    @FocusState private var isFocused: Bool
    @Environment(\.modelContext) private var modelContext
    
    init(promptResponse: PromptResponse) {
        self.promptResponse = promptResponse
        self.response = promptResponse.response
    }
    
    func saveResponse() {
        self.promptResponse.response = response
        try? self.modelContext.save()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(promptResponse.prompt)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            Divider()
            TextField("Type your response here", text: $response, axis: .vertical)
                .focused($isFocused)
                .onChange(of: isFocused) { wasFocused, isFocused in
                    if (wasFocused && !isFocused){
                        saveResponse()
                    }
                }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(
            cornerRadius: 8, style: .continuous
        ))
    }
}
