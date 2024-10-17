# IOSTechTest


This application is build on SwiftUI which simply makes a api call and lists the users, we can see all the details of the user in the detail screen like his Name, profilePic, email, phoneNumber, gender, age and his address. This app can be installed on below mentioned devices.

**DevicesType**: All IOS Devices,

**Minimum IOS-Version**: 15.0 and above



We have used the free api from : https://github.com/public-apis/public-apis/blob/master/README.md
to get the users list and there details, Once we scroll the list of users and on reaching the end user api request is made again and new set of users are displayed again.

App is using the apples new async way of makeing the api request using the urlrequest. once api calling is completed we will check if any errors occured during the call if any api error occurs immediately warn the user about the error, If everything is fine and we receive the data and then we process to decode the data using the decodable protocol and the end result is passed to the requested function, as we have used swiftui and made viewmodel to confirm to observableobject any change in viewmodel will trigger the view to update the change.

We have followed the solid principles while building the application, we used Dependency injection and dependency iversion for defining the viewmodel and api service calls and MVVM as the architectual pattern for the application.

Below are the Screenshots attached on how the application looks

![Simulator Screenshot - iPhone 15 Pro - 2024-10-17 at 15 48 26](https://github.com/user-attachments/assets/fb4954eb-b7bc-4f9e-b8c3-800ebba481a4)


![Simulator Screenshot - iPhone 15 Pro - 2024-10-17 at 15 48 30](https://github.com/user-attachments/assets/0df392f4-32bb-4ccf-a7f9-34a3767b6ec6)
