# Logistic (iOS)
Logistic project  shows the list of delivery Items and their delivery location on map. 

# Installation
To run the project :
- a) Navigate to root folder of the project. 
- b) Open the terminal and cd to the directory containing the Podfile
- c) Delete the existing Podfile.lock, Pods, and Assignment.xcworkspace file if exists
- d) Run the "pod install" or "pod update"command
- e) Open xcworkspace and run the app 

# Requirement :
- MacOs: 10.14
- Xcode : 10.2

# Supported Version
- iOS :  (11.x, 12.x)  

# Language 
- Swift 5.0

# Design Pattern
## VIPER

![viper1](https://user-images.githubusercontent.com/10114818/58870811-855f7c80-86de-11e9-884e-85ffef2d54fd.png)

- View: Class that has all the code to show the app interface to the user and get their responses. Upon receiving a response View alerts the Presenter. it contains view and viewcontroller.

- Presenter : Nucleus of a module. It gets user response from the View and work accordingly. Only class to communicate with all the other components. Calls the router for wire-framing, Interactor to fetch data (network calls or local data calls), view to update the UI.

- Interactor : Has the business logics of an app. Primarily make API calls to fetch data from a source. Responsible for making data calls but not necessarily from itself.

- Router : This layer does the wire-framing. Listens from the presenter about which screen to present and executes that.

- DataManager : This layer between API Manager and Database Manager and our module fetch data from this layer.

- Entity :  Contains plain model classes used by the interactor.

# Version
- 1.0

# Data Caching
1. Core Data is used for app data.
2. SDWebImage is used for Image cache. The expiration time is one week. 
3. SDWebImage will automatically handle the image disk storage expiration. 
4. Pull to refresh functionality is implemented in the following way:
- If the user has a valid internet connection then latest data (with offset 0) has been pulled from the server.
- If the app receives valid data then old all core data is deleted.
- If all data successfully deleted then new data is saved in core data.
- And data received from the remote server are populated on view.
- If the app has no internet connection then the corresponding error is displayed.

# Assumptions        
1. The app is designed for iPhones and with portrait mode.     
2.  App localization is implemented. However, currently, only the English language is supported. 
3.  Supported mobile platforms are iOS (11.x, 12.x)        
4.  Device support - iPhone 5s, iPhone 6 Series, iPhone SE, iPhone 7 Series, iPhone 8 Series, iPhone X Series    
5.  iPhone app support would be limited to portrait mode.
6.  Data caching is available, but data syncing(checking duplicates/removal/delete) is not supported right now.
   - a) The app will data from cache till the data available
   - b) If offset data not available in the cache, the app will fetch data from the server from starting from that offset.
   - c) If any cached data is updated on the server then updating into local data is not considered.
   - d) If any cached data is deleted from the server then local cache data will not delete.

# "Firebase Crashlytics"
The Firebase Crashlytics is integrated into the project to collect the crash reports. The crash report will be available on the firebase console. 
To change the firebase account, follow the below steps:
1. Go to https://console.firebase.google.com/ and create an app
2. Enter the Projects bundle identifier i.e com.assignment.Assignment
3. Fill the other relevant details and download the GoogleService-Info.plist file.
4. Now navigate to Resource folder to the app and replace the existing GoogleService-Info.plist file with your new GoogleService-Info.plist file.
5. Run the app
6. For more details about the Firebase Crashlytics integration, follow details on this link : https://firebase.google.com/docs/crashlytics/get-started

# "SwiftLint"
1. Install the SwiftLint is by downloading SwiftLint.pkg from latest GitHub release and running - https://github.com/realm/SwiftLint/releases
2. Or by HomeBrew by running "brew install swiftlint" command
3. Add the run script in the xcode (target -> Build pahse -> run script -> add the script) if not added
4. If need to change the rules of swiftlint, goto root folder of the project
5. Open the .swiftlint.yml file and modify the rules based on the requirement

# "Cocoa Pod Used"      
1. Alamofire
2. SDWebImage
3. OHHTTPStubs/Swift
4. ReachabilitySwift
5. Fabrics
6. Crashlytics
7. Nimble
8. Quick
# Code Coverage
- Just need to run Test on Xcode ( cmd+U )
- Code coverage of CoreData class is less because NSBatchDeleteRequest is not supported for InMemory type persistence store coordinator.

## Unit Testing
- Unit testing is done by using Nimbel,Quick,XCTest.
- Protocols are used for mocking the data.

# Application Screenshot
![deliveryList](https://user-images.githubusercontent.com/10114818/58805224-4c1d0300-8631-11e9-861e-c3468ed5f568.png)

![detail screen shot](https://user-images.githubusercontent.com/10114818/58778164-12c3a380-85ef-11e9-8298-1c534194c6d6.png)

![mapscreen](https://user-images.githubusercontent.com/10114818/58778438-39cea500-85f0-11e9-8986-7d05a7ce3699.png)

# External Library
None

# TODO / IMPROVMENTS 
- UI Test coverage can be increased.
- The coverage can be improved more.

# MIT License

## Copyright (c) 2019 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
