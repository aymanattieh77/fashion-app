# Fashion App

## Description
The eCommerce Fashion Flutter app is a mobile application designed to provide
users with a seamless and convenient shopping experience for clothing items.
With a user-friendly interface and a wide range of clothing categories, the app
aims to cater to fashion enthusiasts and shoppers looking for the latest trends and
styles.

## Key Features

❖ User Authentication and Registration: Users can create accounts, log in
securely, and manage their profiles to access personalized features and
order history.

❖ Browse and Search: Users can easily explore a diverse selection of clothing
items, organized by categories, brands, or price ranges. A search
functionality allows for quick and specific item searches.

❖ Product Details: Each clothing item is accompanied by detailed product
information, including images, descriptions, sizes, colors, and customer
reviews.

❖ Shopping Cart Management: Users can add desired items to their shopping
carts, view and update the cart contents, and remove items as needed.

❖ Secure Checkout: The app offers a secure and streamlined checkout
process, allowing users to choose from multiple payment options and enter
shipping details for a seamless transaction.

❖ User Profile Management: Users can manage their personal information,
view, and edit their shipping addresses, and update their preferences.

## Architecture and Code Organization

### Clean Architecture (MVVM) With Bloc State Management

#### Folder Structure

- Config
     - app routes, services, cache, and permissions
     - Language Manager.
     - service locator (DI).
- Controllers
    - All Cubits and blocs.
    - Business Logic.
- Core
    - error handlers and exceptions.
    - extensions and functions.
    - network information.
    - uilts (contains app Strings, colors, style, assets, and constants).
- Data
    - Data Source (Remote, Local).
    - Dio Factory.
    - Repository Implementation.
    - Models and Mappers.
- Domain
    - Entities.
    - Repository Interfaces.
    - Usecases
- View
    - Screens (Contain All UI Screens, Pages, Own Widgets).
    - Widgets.
    - State Renderer.

## Screens
- Splash.
- On Boarding.
- Authentication
     - Registration
     - Login with E-mail & Password.
     - Login with Facebook.
     - Login With Google.
     - Forget Password.
     - Logout.
- Home
     - Products List view show freshness clothing items by category.
     - The profile page contains account information.
     - The Catalog Page Categorize clothing for men and women.
- Search
     - searching for clothing items by category, brand, or price range.
- Categories
     - show clothing items by category and Filtering items.
- Product Details
     - Each clothing item is accompanied by detailed product information.

- Favorites
     - Contains favorites Products.
     - Shopping Cart
     - Add to Cart functionality.
     - Remove from Cart.
       
- Checkout
     - Set Address Location.
     - Swipe for payment.
       
- Delivery Address
     - Add, Delete, and Update Address.
     - Pick Location from google map.
     - 
- Settings
    - Change App Language.
    - Enable dark mode.
    - Update user profile.
    - 
- Notifications.
- About Us.
- Privacy Policy.



## Login & Registration
 
  ![login_registration](https://github.com/aymanattieh77/fashion-app/assets/87063387/8af21aad-6519-4dbc-af4c-8c4e23b427e2)

## Home & Menu Side Bar
 
  ![Homescreen_menu](https://github.com/aymanattieh77/fashion-app/assets/87063387/ff5a02c4-c1a8-4247-b927-d15420f9203f)

## Product Detail & Categories & Search

  ![productdetail_cate_search](https://github.com/aymanattieh77/fashion-app/assets/87063387/1518d170-3e18-4e42-8c37-4b175afe5949)

## Cart & Checkout & Payment

  ![cart_checkout_payment](https://github.com/aymanattieh77/fashion-app/assets/87063387/5c7d3345-94eb-4f2a-be64-accb933b13c8)

## Delivey Address & Account & General Settings

   ![delivery_account_general_settings](https://github.com/aymanattieh77/fashion-app/assets/87063387/0f246dc6-8cca-4227-96bf-eb962f791962)

## Favourites & About & App Rate
 
   ![favourites_faq_about_rate](https://github.com/aymanattieh77/fashion-app/assets/87063387/1e01fa9c-72da-4eb4-ad07-4b5eac52b683)


## Features and Functionality
- User authentication and registration.
- RESTful APIs.
- Integrated with Firebase Backend.
- Stripe Integration for Payment Support.
- Browsing and searching for clothing items by category, brand, or price
range.
- Product details page with images, descriptions, and customer reviews.
- Shopping cart management and adding/removing items.
- Delivery Address adding / removing /updating Address.
- Google Map /get your current Location.
- Secure checkout process with payment.
- Favorites functionality.
- User profile management.
- Support multiple language (Arabic, English).
- Support dark mode.
- Edit Profile Account.
- Settings.
- Drawer Menu.
- Backend
    - Database system with Firebase Firestore.
    - User management with Firebase Authentication
    - Photo storage with Firebase Storage.
    - Payments with Stripe SDK.
      

## Packages
- flutter_svg: ^2.0.6
- flutter_bloc: ^8.1.3
- get_it: ^7.6.0
- firebase_core: ^2.13.1
- firebase_auth: ^4.6.2
- google_sign_in: ^6.1.3
- flutter_facebook_auth: ^5.0.11
- flutter_advanced_drawer: ^1.3.5
- equatable: ^2.0.5
- dartz: ^0.10.1
- shared_preferences: ^2.1.2
- dio: ^5.2.1+1
- retrofit: ^4.0.1
- pretty_dio_logger: ^1.3.1
- cached_network_image: ^3.2.3
- shimmer: ^3.0.0
- skeletons: ^0.0.3
- flutter_slidable: ^3.0.0
- google_maps_flutter: ^2.3.1
- geolocator: ^9.0.2
- geocoding: ^2.1.0
- lottie: ^2.4.0
- permission_handler: ^10.3.0
- page_transition: ^2.0.9
- smooth_page_indicator: ^1.1.0
- infinite_scroll_pagination: ^3.2.0
- flutter_phoenix: ^1.1.1
- internet_connection_checker: ^1.0.0+1
- easy_localization: ^3.0.2
- fluttertoast: ^8.2.2
- cloud_firestore: ^4.8.2
- flutter_stripe: ^9.2.2
- image_picker: ^1.0.1
- firebase_storage: ^11.2.5
- flutter_dotenv: ^5.1.0

