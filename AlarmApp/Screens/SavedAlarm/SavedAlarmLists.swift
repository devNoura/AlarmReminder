import SwiftUI


struct ContentView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color("text"))]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        
    }
    
    @State var isEditing = false
    @State var selection = Set<String>()
    @State var issnoozed: Bool=false
    @State var isOnFirstItem = false
   var names = ["4:13AM", "4:30AM", "7:45PM", "9:20Pm"]
    
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                Text("Alarm")
                    .font(.largeTitle)
                    .foregroundColor(Color("text"))
                    .padding(.trailing, 280)
                    .padding(.top)
                
                
                Text("Sunday,12 Jan")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color("text"))
                    .padding(.trailing, 250.0)
                    .padding(.top)
                
                
                List(names, id: \.self, selection: $selection) { name in
                    VStack {
                        Rectangle()
                            .foregroundColor(Color("circle"))
                            .frame(height: 80)
                            .padding(.top)
                            
                        
                            .overlay {
                               Text(name)
                                 Toggle("", isOn: $isOnFirstItem)
                                    .padding(.trailing)
                                    .toggleStyle(SwitchToggleStyle(tint: Color("back")))
                                  
                                
                                
                            }
                     
                    }
                    .listRowSeparator(.hidden)
                    .cornerRadius(12)
                    
                }
                .onChange(of: isOnFirstItem, perform: { newValue in
                    print("XSXSDSS")
                })
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .foregroundColor(Color("text"))
                .padding(.top)
                .padding(.horizontal)
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).accentColor(Color("blue2"))
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.isEditing.toggle()
                    } label: {
                        Text(isEditing ? "Delet" : "Edit")
                        
                            .foregroundColor(Color("text"))
                            .padding(.bottom)
                            .background(Color("back"))
                        
                        

                        
                            .onAppear {
                                UITableView.appearance().backgroundColor = .clear
                               

                            }
                    }
                }
            }
            
            .padding(.bottom)
            .background(Color("back"))
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
   
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
