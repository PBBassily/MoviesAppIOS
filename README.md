# MoviesAppIOS
iOS application displays a list of movies from https://www.themoviedb.org/

## App Features
1) User can know the overview of the movies by scrolling 

<img src="https://github.com/PBBassily/MoviesAppIOS/blob/master/Screenshots/1.jpeg"  width="200" height = "380" />

2) User can preview more details about each movie by clicking on the corresponding cell

<img src="https://github.com/PBBassily/MoviesAppIOS/blob/master/Screenshots/2.jpeg"  width="200" height = "380" />

3) User can create his/her movie and see it in the My Movies section

<p float="left">
<img src="https://github.com/PBBassily/MoviesAppIOS/blob/master/Screenshots/3.jpeg"  width="200" height = "380" /> 
<img src="https://github.com/PBBassily/MoviesAppIOS/blob/master/Screenshots/4.jpeg"  width="200" height = "380" />
<img src="https://github.com/PBBassily/MoviesAppIOS/blob/master/Screenshots/5.jpeg"  width="200" height = "380" />
</p>


## App Architecture & Design decisions
- The app is built under MVVM design pattern to achieve separation of concerns, and for simplifying unit/UI testing 
- Reusability is achieved as the module for showing a movie is the same module used to create a movie
- The app requests the movies page by page to avoid memory and internet-data drain of the device
- The API is so rich so one tradeoff raised: caching images to save data usage vs memory drain of the app, so the applied solution in the app was to make hybrid algorithm which caches only some fixed number of images (100 is the current number)
- The caching algorithm: the image which is downloaded is cached into the data source, if the number of cached images > MAXIMUM_NUMBER_OF_CACHED_IMAGES, then one image will be deleted, the chosen image to be deleted is the farthest image from the current movie cell
- Unit and UI tests are integrated to raise the quality bar of the app
