# Movie Tracker

MovieTracker is a movie tracking application developed with flutter. Users can see most popular movies.

<img src="https://github.com/osmantuzcu2/movie_tracker/blob/retrofit/assets/images/screenshot.jpg?raw=true">


## Dependencies
  flutter_bloc: for state management, 
  retrofit: for structure,  
  dio:  http client,  
  built_value: retrofit dependecy,  
  json_annotation: for json serialization,  
  get: for routes,  
  flutter_svg: for svg pictures 

## Folder Structure
Each module has a View, State, Controller, ApiClient dart file.This way, you don't have to navigate much outside of the folder you're working in.
Global widgets contain recursively used widgets.
Views contain widgets and everything can be seen.
State contain states for UI.
Controllers using bloC library.
ApiClient work with retrofit and json_serializable


## How to build
    1- Flutter v.2.X must be installed and enviroment must be ready. See more : https://flutter.dev/docs/get-started/install
    2- flutter pub get
    3- flutter run




## Api_key
Movie tracker connects to TMDB with Api_key. If you want to change this, you should edit this line in lib> modules> home> api_client.dart.

    @GET(
      "/movie?sort_by=popularity.desc&api_key=d4706eb28719d30f2911e24ba47428d0")
You should use this command after edit apikey. Because Retrofir generator must run again.
    
    flutter pub run build_runner build
    
https://user-images.githubusercontent.com/29891172/134211467-d6fbb0cf-d8eb-4272-8871-f0f16c7057d1.mp4
