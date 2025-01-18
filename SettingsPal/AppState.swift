//
//  AppState.swift
//  Settings Pal
//
//  Created by @gpoitch on 6/3/24.
//

import SwiftUI
import Contacts
#if !APP_STORE
import Sparkle
#endif

class AppState: ObservableObject {
    @AppStorage("theme") var theme: Theme = .default
    @Published var searchText: String = ""
    @Published var userName: String?
    @Published var userAvatar: Data?
    @Published var contactsStatus = CNContactStore.authorizationStatus(for: .contacts)

    #if !APP_STORE
    lazy var sparkle = SPUUpdater(hostBundle: Bundle.main, applicationBundle: Bundle.main, userDriver: SPUStandardUserDriver(hostBundle: Bundle.main, delegate: nil), delegate: nil)
    #endif

    init() {
        if contactsStatus == .authorized {
            fetchMeContact()
        }

        #if !APP_STORE
        try? sparkle.start()
        #endif
    }

    private func fetchMeContact() {
        do {
            let contact = try CNContactStore().unifiedMeContactWithKeys(toFetch: [
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactThumbnailImageDataKey as CNKeyDescriptor
            ])
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            self.userName = formatter.string(from: contact)
            self.userAvatar = contact.thumbnailImageData
        } catch {
            print("Failed to fetch contact: \(error)")
        }
    }

    func fetchMeContactWithAccessRequest() {
        // To reset permissions for testing: `tccutil reset AddressBook`
        CNContactStore().requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                self.contactsStatus = CNContactStore.authorizationStatus(for: .contacts)
                if granted {
                    self.fetchMeContact()
                }
            }
        }
    }
}
