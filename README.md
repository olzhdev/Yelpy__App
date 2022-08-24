## About the app

<p align="center">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468499-4283b252-3e8b-4d25-8613-c88f581e3da6.png">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468509-c6fe9305-9540-4cdb-b1a3-85b1871f53d0.png">
</p>
<p align="center">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468524-bacddee0-4044-4706-9c58-4596ab5dd28e.png">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468535-2b52e43c-46c1-4830-902c-b313ba4a7d14.png">
</p>

### Yelpy

Yelpy is an application for discovering various restaurants and cafes by category. Detailed information about the business, the ability to visit the website, add to favorites. 

## Concepts used

* Fully programmatic UI (Autolayout).
* MVP+C.
* External libraries: SDWebImage, SkeletonView.
* MapKit.
* JSON parsing using Codable.
* HTTP requests with URLSession.
* Data persistence using CoreData.
* REST API (YelpFusion API).

## Application architecture overivew

* MVP+C architecture.
* Coordinator pattern for navigation.
* Coordinator, Module (view + presenter + managers) builders for creating individual entities, injecting dependencies.
<p align="center">
<img height=500 width=800 src="https://user-images.githubusercontent.com/53051473/186411868-19dfd330-09dc-4e23-ab8d-0b6f7cac2e73.png">
</p>
<sup>The scheme may be slightly different because the functionality and other modules are added.</sup>

## Plans

- Determining the user's current location
- Adding more filters for searching

##
<p align="center">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468437-ce40224d-cafd-4c5f-b7e3-50d31b6f0f3c.gif">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468459-9a8b6fef-d149-41fa-93f7-b6b0b48b67c9.gif">
<img height=360 width=180 src="https://user-images.githubusercontent.com/53051473/183468483-2d6aa7a2-b6aa-4d96-9842-676c39ad1240.gif">
</p>
