import SwiftUI


struct ResponseView: View {
    @Bindable var promptResponse: PromptResponse
    
    let placeholder = "Type your response here"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(promptResponse.prompt)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            ScrollView {
                ZStack(alignment: .topLeading) {
                    Divider()
                    Text(promptResponse.response == "" ? placeholder : promptResponse.response)
                        .padding(6)
                        .padding(.top, 2)
                        .opacity(promptResponse.response == "" ? 0.5 : 0)
                    TextEditor(text: $promptResponse.response)
                        .frame(alignment: .leading)
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}
