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


#  Features

There are some few features in this app. These are 
- Inifinity Scrolling
- Waterfall Grid
- Detailed Photo View
- Image Caching
- Response Caching
- Theme Support (Dark/Light)

## Infinity Scrolling

This app has a feature of inifinity scrolling. The main complexity of the problem is handling the memory because if inifinte response are in app memory, it will crash the whole app. So for the better perfomance ,  I have done using database(<B>Core Data</B>). So i am deleting alll the database info in launching the app. Then, in success response i will store all the data in database based on id. And when cell needs information, it will fetech the information from database. So app memory is not increased. It is a  bit slower approch. So, for increasing the performance and better user experience , I prefectch the data and store in cache. So, for updating cell, I will first search in cache and if it is not found in cache, then I fetch data from database.


## Waterfall Grid
Waterfall grid is a eye soothing view for user. The app is now look like pinterest. This feel is given by a custom collectionviewfloylayout. This flowlayout delegate hight setter for collection view cell. This data is also comes from database or cache.

## Detailed Photo View
Detailed photo view is feature where raw imagees are shown. It will also cache the response managed by kingfisher. In detailed view page, photos are zoomed in and out by pinch gesture. The photo is also sharable, copyable and saveable in photos(iphone gallary).

## Image and Response Caching
Image caching are managed by kingfisher. The collection view cell image sand detailed photo images are cached. In here we set highest cache memory uses for avoid the memory warning issue. Response are cached by alamofire as well.




## Theme support

This app also has a great feature of theme support based on ios default theme app. This means both light and dark mode is supported.


# App Screenshot

Dark Mode             |  Light Mode
:-------------------------:|:-------------------------:
![](/Resource/dark_mode/IMG_2992_iphone13blue_portrait.png)  |  ![](/Resource/light_mode/IMG_2997_iphone13blue_portrait.png)
![](/Resource/dark_mode/IMG_2993_iphone13blue_portrait.png) |![](/Resource/light_mode/IMG_2998_iphone13blue_portrait.png)
![](/Resource/dark_mode/IMG_2994_iphone13blue_portrait.png) | ![](/Resource/light_mode/IMG_3001_iphone13blue_portrait.png)
![](/Resource/dark_mode/IMG_2996_iphone13blue_portrait.png) |![](/Resource/light_mode/IMG_3003_iphone13blue_portrait.png)

