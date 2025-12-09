# HyperGarageSale – Final Project
Course: Mobile Application Development  
Student: Yulin

## Project Description
HyperGarageSale is a simple classified posting app that allows users to create and browse garage-sale style posts. Each post contains a title, price, description, and optional photos. The app includes a main browsing page and a New Post page. Firebase is used to store post data and images.

## Features Implemented

### Step 1 – New Post Screen
- Three text fields: Title, Price, Description  
- Button to submit a new post

### Step 2 – Menu & Snackbar
- AppBar with a menu option to open the New Post screen  
- Snackbar displayed when a post is successfully added

### Step 3 – BrowsePosts Screen
- BrowsePosts is the main page of the app  
- Floating Action Button to navigate to the New Post page

### Step 4 – ListView
- ListView showing all posts retrieved from the database  
- Displays basic text information and a preview image

### Step 5 – Images
- Users can upload up to four images when creating a post  
- Thumbnails shown in the New Post form  
- Post detail screen displays all images, and images open fullscreen when tapped

### Step 6 – Firebase Integration
- Firebase Authentication (anonymous sign-in)  
- Firestore database for storing posts  
- Firebase Storage for storing images  
- Firebase initialized using firebase_options.dart

## How to Run

### iOS
flutter run -d "iPhone SE (3rd generation)"

### Android
flutter run -d emulator-5554

### Web
flutter run -d chrome

## Project Structure
lib/  
  main.dart  
  browse_posts.dart  
  new_post.dart  
  post_detail.dart  
  firebase_options.dart  

## Summary
This project completes all assignment steps including UI creation, navigation, ListView display, image upload and preview, and full Firebase integration.
