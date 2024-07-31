//
//  mainPage.swift
//  nearme
//
//  Created by Scholar on 7/30/24.
//

import SwiftUI
// Event Model
struct Event: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let description: String
}
// ViewModel
class EventViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedCategory: String? = nil
    var filteredEvents: [Event] {
        if let category = selectedCategory {
            return events.filter { $0.category == category }
        } else {
            return events
        }
    }
    init() {
        events = [
            Event(title: "Stavros Niarchos Library", category: "Arts & Humanities", description: "Come hang out at the library to discuss books and make bracelets!"),
            Event(title: "Volleyball Court", category: "Sports", description: "Come play volleyball at Juniper Park and master your volleyball skills."),
            Event(title: "NYC Hall of Science", category: "STEM", description: "Come explore the exhibitions and fun activities at the museum! Kids and teens are welcome."),
            Event(title: "Teens Take The Met", category: "Arts & Humanities", description: "Screenings, art, snacks, and freebies along with fun workshops at the Met just for teens!")
        ]
    }
    func filter(by category: String?) {
        selectedCategory = category
    }
}
// Event Detail View
struct EventDetailView: View {
    var event: Event
    var body: some View {
        
        ZStack {
             // Lighter gradient background
             LinearGradient(
               gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]),
               startPoint: .topLeading,
               endPoint: .bottomTrailing
             )
             .edgesIgnoringSafeArea(.all) // Extend gradient to the edges of the screen
            

            
            VStack {
                Spacer()
                    .frame(height: 15.0)
                VStack(alignment: .leading, spacing: 20) {
                    // Event detail section
                    
                    Text(event.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 15)
                        .foregroundColor(.black) // Set text color to black
                    
                    Text("Category: \(event.category)")
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Divider()
                    
                    Text(event.description)
                        .font(.body)
                        .foregroundColor(.black)
                    
                    // New text lines for number of people and gender
                    Text(" 👥 Number of people coming: 20")
                                .font(.subheadline)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding([.leading, .top, .trailing], 15)
                                .foregroundColor(.blue.opacity(0.8)) // Set text color to black
                    Text(" 🌈 Gender of people coming: Mixed")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding([.leading, .trailing], 15)
                                .foregroundColor(.blue.opacity(0.8)) // Set text color to black
                    Text(" 📍 Location: Central Park")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding([.leading, .bottom, .trailing], 15)
                                .foregroundColor(.blue.opacity(0.8)) // Set text color to black
                              // Description text at the bottom
                    
                    Text("Join us for a day of community service as we clean up Central Park. Your participation helps make our city a better place!")
                                .font(.body)
                                .foregroundColor(.black) // Set text color to black
                                .padding(.all, 10)
                              
                    
                }
                
            }
            .padding()
                  .background(RoundedRectangle(cornerRadius: 15).fill(Color(UIColor.systemBackground)))
                  .shadow(radius: 5) // Shadow applied to the box
                  .padding()
            Spacer()
                .frame(height: 20.0)
        }
        
    }
}
// Main View
struct EventListView: View {
    @ObservedObject var viewModel = EventViewModel()
    var body: some View {
            
            NavigationView {
                VStack {
                    
                    // Custom Tab Bar for Filtering
                    HStack {
                        
                        Button(action: {
                            viewModel.filter(by: "Arts & Humanities")
                        }) {
                            Text("Arts & Humanities")
                                .padding()
                                .background(viewModel.selectedCategory == "Arts & Humanities" ? Color.blue.opacity(0.8) : Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        Button(action: {
                            viewModel.filter(by: "Sports")
                        }) {
                            Text("Sports")
                                .padding()
                                .background(viewModel.selectedCategory == "Sports" ? Color.blue.opacity(0.8) : Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        Button(action: {
                            viewModel.filter(by: "STEM")
                        }) {
                            Text("STEM")
                                .padding()
                                .background(viewModel.selectedCategory == "STEM" ? Color.blue.opacity(0.8) : Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        Button(action: {
                            viewModel.filter(by: nil) // Show all events
                        }) {
                            Text("All")
                                .padding()
                                .background(viewModel.selectedCategory == nil ? Color.blue.opacity(0.8) : Color.blue.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    // Event List
                    
                    List(viewModel.filteredEvents) {
                        event in
                        NavigationLink(destination: EventDetailView(event: event))
                        {
                            
                            VStack(alignment: .leading) {
                                
                                Text(event.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                                    .multilineTextAlignment(.center)
                                    .padding([.top, .bottom, .trailing], 10.0)
                                Text(event.description)
                                    .font(.body)
                                    .foregroundColor(.black)
                                    .padding([.top, .bottom, .trailing], 10.0)
                                
                            }
                            
                        }
                        
                    }
                    
                    .navigationTitle("NearYou")
                    
                }
                
            }
        
        }
        
        
    }
    
    
    struct EventListView_Previews: PreviewProvider {
        static var previews: some View {
            EventListView()
        }
    }
    
    
