import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State var isSearching: Bool = false
    var placeholder = "Введите запрос"
    
    var body: some View {
        HStack {
            
            Image("SearchIcon")
                .foregroundColor(.ypGray)
                .padding(.leading, 8)
            
            TextField(placeholder, text: $searchText, onEditingChanged: { isEditing in
                isSearching = isEditing
            })
            .font(.system(size: 17))
            .padding(.leading, 2)
            .autocorrectionDisabled(true)
            .autocapitalization(.none)
            .cornerRadius(16)
            .foregroundStyle(.ypBlack)
            
            if isSearching {
                Button(action: { searchText = "" }) {
                    Image("SearchClear")
                        .foregroundColor(.ypGray)
                        .padding(.trailing, 7)
                }
            }
        }
        .frame(height: 36)
        .background(.ypLightGrayBar)
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}
