//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Cory Steers on 9/20/23.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortingSheet = false
    @State private var sort = SortType.name
    
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortType {
        case name, date
    }
    
    let filter: FilterType
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if filter == .none {
                            if prospect.isContacted {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "person.crop.circle.badge.xmark")
                                    .foregroundColor(.red)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        .swipeActions {
                            if prospect.isContacted {
                                Button {
                                    prospects.toggle(prospect)
                                } label: {
                                    Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                                }
                                .tint(.blue)
                            } else {
                                Button {
                                    prospects.toggle(prospect)
                                } label: {
                                    Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                                }
                                .tint(.green)
                                
                                Button {
                                    addNotification(for: prospect)
                                } label: {
                                    Label("Remind Me", systemImage: "bell")
                                }
                                .tint(.orange)
                            }
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                    Button {
                        isShowingSortingSheet = true
                        
                    } label: {
                        Label("Change sort order", systemImage: "arrow.up.arrow.down.circle")
                    }

                Button {
                        isShowingScanner = true
                        
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com", completion: handleScan)
            }
            .confirmationDialog("Select a sortiing method", isPresented: $isShowingSortingSheet) {
                Button {
                    self.sort = .name
                } label: {
                    Text("Sort contacts by name")
                }
                
                Button {
                    sort = .date
                } label: {
                    Text("sort contacts by date added")
                }
            }
        }
    }
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        let sortedProspects = prospects.people.sorted {
            switch sort {
            case .name:
                $0.name < $1.name
            case .date:
                $0.dateAdded > $1.dateAdded
            }
        }
        
        switch filter {
        case .none:
            return sortedProspects
        case .contacted:
            return sortedProspects.filter { $0.isContacted }
        case .uncontacted:
            return sortedProspects.filter { !$0.isContacted }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(person)
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) // for production
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // for testing
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .environmentObject(Prospects())
}
