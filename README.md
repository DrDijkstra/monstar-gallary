# Introduction

 In this project,  a simple <B>"Monstar Lab"</B> iOS app is created that displays a list of photos as a gallery. Users can tap the photo to see a full-screen view of it with the possibility to zoom in and out.

# Setup Tools 
For setup the project in mac machine, you need 
- XCode 13.4

Minimum ios support version, for this app is
- iOS 13.0

The frameworks used for making the project are
- Alamofire
- Object Mapper
- Kingphiser
- UIkit
- CoreData
## Alamofire
Alamofire is mainly used for http network call like get, put, post, delete. It is also responsible for cache the response.  For more info, please vist [Alamofire](https://github.com/Alamofire/Alamofire).

## Object Mapper
Object Mapper is used for json serialiazation and deserialzation. I am using carthage to use the object mapper. For more info, please visit [Object Mapper](https://github.com/tristanhimmelman/ObjectMapper).


## Kingpfisher
Kingfiser is used for image downloading and caching. For more info, plaease visit [Kingfiser](https://github.com/onevcat/Kingfisher).

## UIKit
UIKit is a framework supported by apple used here for buliding the UI/UX flow. For more info, please visit [UIKit](https://developer.apple.com/documentation/uikit).

## Core Data
Core data is responsible for client side database which is supported by apple. For more query, please visit [Core Data](https://developer.apple.com/documentation/coredata).

All of the frameworks except apple supported frameworks are used by [carthage](https://github.com/Carthage/Carthage) for dependancy injection.

# Architecture of the framework

This app is mainly designed with modified VIPER architechure pattern. 

The entity(E) in VIPER is accessable in service manager component. There are mainly three components required for constucting this app.
- Service Layer
- Network Layer
- Database layer


## Service Layer
Service Layer is used to make request ready for network layer and make response ready to app layer. Mainly it is the data processing unit to make network call with by alamofire. Appcliation only use service layer to do any network call or use other services like database access.


## Network Layer
Network layer is basically responsible for any network call like REST. It consists of router, intercetor , json serialiazer and many other network releated module.


## Database Layer
Database layer deals with data stored in rom. It is managed by Core Data which basically uses sqlite. Database layer is only accessible from service layer. 


![arch](/Resource/arch.png)


#  Infinity Scrolling 





Dark Mode             |  Light Mode
:-------------------------:|:-------------------------:
![](/Resource/dark_mode/IMG_2992_iphone13blue_portrait.png)  |  ![](/Resource/light_mode/IMG_2997_iphone13blue_portrait.png)
![](/Resource/dark_mode/IMG_2993_iphone13blue_portrait.png) |![](/Resource/light_mode/IMG_2998_iphone13blue_portrait.png)
![](/Resource/dark_mode/IMG_2994_iphone13blue_portrait.png) | ![](/Resource/light_mode/IMG_3001_iphone13blue_portrait.png)
![](/Resource/dark_mode/IMG_2996_iphone13blue_portrait.png) |![](/Resource/light_mode/IMG_3003_iphone13blue_portrait.png)

