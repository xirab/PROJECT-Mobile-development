
import SwiftUI

struct ContentView: View {
    @ObservedObject var schedules = RequestFactory()
    
    var body: some View {
        Text("Hello World")
        RequestFactory().getScheduleList{ ( schedules) in
            if let list = schedules, let schedule = list.last{
                print(schedule.id)
            }
            else{
                print("We got a problem Houston!")
            }
        }
    }.navigationTitle("Schedule")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
