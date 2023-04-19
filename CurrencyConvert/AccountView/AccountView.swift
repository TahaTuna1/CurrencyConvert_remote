

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel = AccountViewModel()
    @FocusState private var focusedTextField: FormTextField?
    
    enum FormTextField{
        case firstName, lastName, email
    }
    
    var body: some View {
        
        ZStack{
            Form{
                
                HStack {
                    Image(systemName: "person").font(.largeTitle)
                    
                    Text("User Settings")
                }
                Section(header: Text("Personal Info")) {
                    TextField("First Name", text: $viewModel.user.firstName)
                        .focused($focusedTextField, equals: .firstName)
                        .onSubmit { focusedTextField = .lastName }
                        .submitLabel(.next)
                    
                    TextField("Last Name", text: $viewModel.user.lastName)
                        .focused($focusedTextField, equals: .lastName)
                        .onSubmit { focusedTextField = .email }
                        .submitLabel(.next)
                    
                    TextField("Email", text: $viewModel.user.email)
                        .focused($focusedTextField, equals: .email)
                        .onSubmit { focusedTextField = nil}
                        .submitLabel(.continue)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .disableAutocorrection(true)
                    
                    
                    DatePicker("Birthday", selection: $viewModel.user.birthDate,
                               in: Date().oneHundredTenYearsAgo...Date().eighteenYeasAgo, displayedComponents: .date)
                    
                    Button{
                        viewModel.saveChanges()
                    } label:{
                        Text("Save Changes").foregroundColor(Color("AccentColor2"))
                    }
                }
                
            }
            .navigationTitle("👩🏻‍💼Account")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Dismiss"){ focusedTextField = nil }
                }
            }
            
        }.preferredColorScheme(.dark)
        .onAppear{
            viewModel.retrieveUser()
        }
        .alert(item: $viewModel.alertItem){ alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}


struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
