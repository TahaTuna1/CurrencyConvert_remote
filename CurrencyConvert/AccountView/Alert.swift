import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}
struct AlertContext{
    static let invalidEmail = AlertItem(title: Text("Invalid Email"),
                                        message: Text("The email you entered is not valid. Please enter a valid email adress."),
                                        dismissButton: .default(Text("OK" )))
    
    static let emptyFields = AlertItem(title: Text("Empty Fields"),
                                       message: Text("Account fields cannot be empty."),
                                       dismissButton: .default(Text("OK" )))
    
    static let userSaveSuccess = AlertItem(title: Text("Profile Saved"),
                                           message: Text("Your profile information was successfully saved"),
                                           dismissButton: .default(Text("OK" )))
    
    static let invalidUserData = AlertItem(title: Text("Profile Error"),
                                           message: Text("There was an error saving or retrieving your profile"),
                                           dismissButton: .default(Text("OK" )))
}
