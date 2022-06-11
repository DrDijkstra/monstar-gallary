# Introduction

 In this project,  a simple <B>"Monstar Lab"</B> iOS app is created that displays a list of photos as a gallery. Users can tap the photo to see a full-screen view of it with the possibility to zoom in and out.

# Setup Tools 
For setup the project in mac machine, you need 
- XCode 13.4

Minimum ios version support, for this app is
- iOS 13.0

The frameworks used for making the project are
- Alamofire
- Object Mapper
- Kingphiser
- UIkit
- CoreData
## Alamofire
Alamofire is mainly used for http network call like get, put, post, delete. It is also cache the response.  For more info, please vist [Alamofire](https://github.com/Alamofire/Alamofire).

## Object Mapper
Object Mapper is mainly used for json serialiazation and deserialzation. I am using carthage to use the object mapper. For more info, please visit [Object Mapper](https://github.com/tristanhimmelman/ObjectMapper).


## Kingpfisher
Kingfiser is used for image downloading and caching. For more info, plaease visit [Kingfiser](https://github.com/onevcat/Kingfisher).

## UIKit
UIKit is a framework supported by apple used here for buliding the UI/UX flow. For more info, please visit [UIKit](https://developer.apple.com/documentation/uikit).

## Core Data
Core data is responsible for client side database which is supported by apple. For more query, please visit [Core Data](https://developer.apple.com/documentation/coredata).

All of the frameworks are used by [carthage](https://github.com/Carthage/Carthage) for dependancy injection.

# Architecture of the framework

This app mainly designed with modified VIPER architechure pattern. 
[MarineGEO circle logo](/Resource/arch.png)
