
import SwiftUI

final class AccountViewModel: ObservableObject{
    
    @AppStorage("user") private var userData: Data?
    
    @Published var user = User()
    @Published var alertItem: AlertItem?
    
    
    func saveChanges(){
        guard isValidForm else { return }
        
        //Encode User and Save
        do{
            let data = try JSONEncoder().encode(user)
            userData = data
            alertItem = AlertContext.userSaveSuccess
        } catch{
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func retrieveUser(){//Decode User and Use
        guard let userData else { return }
        
        do{
            user = try JSONDecoder().decode(User.self, from: userData)
        }catch{
            alertItem = AlertContext.invalidUserData
        }
    }
    
    var isValidForm: Bool{
        guard !user.firstName.isEmpty && !user.lastName.isEmpty && !user.email.isEmpty else {
            alertItem = AlertContext.emptyFields
            return false
        }
        
        guard user.email.isValidEmail else{
            alertItem = AlertContext.invalidEmail
            return false
        }
        
        return true
    }
    
    
}
