//
//  AppState.swift
//  Settings Pal
//
//  Created by @gpoitch on 6/3/24.
//

import SwiftUI
import Contacts

class AppState: ObservableObject {
    @AppStorage("theme") var theme: Theme = .classic
    @Published var searchText: String = ""
    @Published var userName: String?
    @Published var userAvatar: Data?
    @Published var contactsStatus = CNContactStore.authorizationStatus(for: .contacts)

    init() {
        if contactsStatus == .authorized {
            fetchMeContact()
        }
    }

    private func fetchMeContact() {
        do {
            let contact = try CNContactStore().unifiedMeContactWithKeys(toFetch: [
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactMiddleNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                CNContactThumbnailImageDataKey as CNKeyDescriptor
            ])
            let formatter = CNContactFormatter()
            formatter.style = .fullName
            self.userName = formatter.string(from: contact) ?? "\(contact.givenName) \(contact.familyName)"
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
