# MoneyJar
Multi-asset savings tracker for iOS

Minimum deployment: iOS 16. The app is built with SwiftUI using the new NavigationStack API. Business logic is separated from Views and resides in the Model class, which helps to implement Unit Tests. Protocols enable the injection of mock instances of storage and networking clients during Unit Tests. REST API is used to fetch the latest foreign exchange rates. Networking requests utilize async/await. Here I use FileManager for app persistence.
