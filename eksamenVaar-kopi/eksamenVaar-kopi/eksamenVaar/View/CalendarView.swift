

import SwiftUI

struct CalendarView: View {
    @Binding var date: Date
    @Binding var isCalendarPresented: Bool
    @State var isFutureDatesDisabled = true
    
    
    var body: some View {
        //Kalender
        //https://sarunw.com/posts/swiftui-multidatepicker/
        DatePicker(
            "Start Date",
            selection: $date,
            //https://stackoverflow.com/questions/73081502/how-to-disable-the-future-date-selection-from-datepicker-in-swiftui
            //https://developer.apple.com/documentation/foundation/nsdate/1415385-distantfuture
            in: isFutureDatesDisabled ? ...Date() : ...Date.distantFuture,
            displayedComponents: [.date]
        )
        .datePickerStyle(.graphical)
        
        Button(action: {
            isCalendarPresented = false
            
        }) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.blue, lineWidth: 2)
                .frame(width: 160, height: 40)
                .overlay(
                    Text("Velg")
                        .foregroundColor(Color.blue)
                )
        }
        Button(action: {
            //Skrur av og på muligheten for å velge fremtidige datoer
            isFutureDatesDisabled = !isFutureDatesDisabled
        }) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(isFutureDatesDisabled ? Color.red : Color.blue, lineWidth: 2)
                .frame(width: 200, height: 40)
                .overlay(
                    Text((isFutureDatesDisabled ? "Aktiver" : "Deaktiver") + " fremtidig dato")
                        .foregroundColor(isFutureDatesDisabled ? Color.red : Color.blue)
                )
        }
    }
    
}


