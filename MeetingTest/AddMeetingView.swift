//
//  AddMeetingView.swift
//  MeetingTest
//
//  Created by Paul du Preez on 30/12/2022.
//

import SwiftUI

struct AddMeetingView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var dateHolder: DateHolder
    
    @State private var meetingImage = UIImage(named: "meeting")!
    @State private var showPhotoOptions = false
    
    enum PhotoSource: Identifiable{
        case photoLibrary
        case camera
        
        var id: Int {
            hashValue
        }
    }
   
    @State private var photoSource: PhotoSource?
    
    @State      var selectedMeeting: Meeting?
    @State      var name:String
    @State      var type:String
    @State      var meetingDate:Date
    @State      var address:String
    @State      var detail:String
    @State      var isWeekly:Bool
    
    
    init(selectedMeeting: Meeting?, initialDate: Date) {
        if let meeting = selectedMeeting {
            _selectedMeeting = State(initialValue: meeting)
            _name = State(initialValue: meeting.name ?? "")
            _type = State(initialValue: meeting.type ?? "")
            _detail = State(initialValue: meeting.detail ?? "")
            _address = State(initialValue: meeting.address ?? "" )
            _meetingDate = State(initialValue: meeting.meetingDate ?? initialDate )
            _isWeekly = State(initialValue: meeting.isWeekly)

        } else {
            _name = State(initialValue: "")
            _type = State(initialValue: "")
            _detail = State(initialValue: "")
            _address = State(initialValue: "")
            _meetingDate = State(initialValue: initialDate)
           _isWeekly = State(initialValue: false)
        }
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section(content: {
                    FormTextField(label: "NAME", placeholder: "Fill in the meeting name", value: $name)
                    FormTextField(label:"Meeting Type",placeholder: "Meeting Type", value: $type)
                    DatePicker("When", selection: $meetingDate, displayedComponents: displayComp())
                    Toggle("Weekly", isOn: $isWeekly)
                    FormTextField(label: "Address",placeholder: "Fill in the meeting address", value: $address)
                    FormTextField(label:"About",placeholder: "Meeting information", value: $detail)
                    
                }, header: {
                    Text("Meeting Details")
                })
            }
                       
            //}
            .navigationTitle("Add Meeting")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.accentColor)
                    }
                }
                ToolbarItem {
                    Button {
                        dismissKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                        save()
                        dismiss()
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.accentColor)
                    }
                }
                
            }
            .actionSheet(isPresented: $showPhotoOptions) {
                ActionSheet(title: Text("Choose your photo source"),
                            message: nil,
                            buttons: [
                                .default(Text("Camera")) {
                                    self.photoSource = .camera
                                },
                                .default(Text("Photo Library")) {
                                    self.photoSource = .photoLibrary
                                },
                                .cancel()
                                
                            ])
            }
 
        }
    }
    private func save() {
         selectedMeeting = Meeting(context: viewContext)
        
        selectedMeeting?.created = Date()
        selectedMeeting?.name         = name
        selectedMeeting?.type         = type
        selectedMeeting?.address      = address
        selectedMeeting?.meetingDate  = meetingDate
        selectedMeeting?.detail       = detail
        selectedMeeting?.isWeekly     = isWeekly
        
        do {
            
            //try viewContext.save()
            try dateHolder.saveContext(viewContext)
        } catch {
            print("Failed to save meeting")
            print(error.localizedDescription)
        }
    }
    
    func displayComp() -> DatePickerComponents {
        return isWeekly ? [.hourAndMinute, .date] : [.date]
    }
    
   
    
    
    struct FormTextView: View {
        
        let label: String
        
        @Binding var value: String
        
        var height: CGFloat = 200.0
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(label.uppercased())
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(.darkGray))
                
                TextEditor(text: $value)
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .padding(.top, 10)
                
            }
        }
    }
    
    struct FormTextField: View {
        
        let label: String
        var placeholder: String = ""
        
        @Binding var value: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(label.uppercased())
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(.darkGray))
                
                TextField(placeholder, text: $value)
                    .font(.system(.body, design: .rounded))
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                    .padding(.vertical, 10)
                
            }
        }
    }
    
    private func saveContext() {
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    
    
    struct AddMeetingView_Previews: PreviewProvider {
        static var previews: some View {
           // AddMeetingView( name: "Text", type: "Open",  meetingDate: Date(), address: "St Mary’s Church (Garden Room) N1 2TX", detail: "all welcome", isWeekly: true)
            
            AddMeetingView(selectedMeeting: Meeting(), initialDate: Date())
                
        }
    }
}

