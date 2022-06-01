# Movies

Movies app allows user to search for movies and see its details.
It uses [OMDB API](http://www.omdbapi.com/#usage)

### Features
1. See List of movies based on search criteria.
2. User can then tap on any movie to see more details about it.

### iOS Support

Minimum iOS version supported is 13.0

### Architectural Pattern

MVVM

### Third party libraries

Used [SDWebImage](https://github.com/SDWebImage/SDWebImage) for image handling.
- The dependency is added using Cocoapods. Need pod install.
- Chose this because its a great image downloader in async mode and also provide caching.

### Areas of improvement / Additions

1. Suppport for the pagination will add lot of value.
2. A more detailed Movie Detail Screen.
3. Unit tests for the Movie Detail View Model.
4. Coordinators for better separation of routing logics.
