# Lensify - Flutter Edition

A Flutter-based frontend for the Lensify eCommerce mobile application, designed to offer a seamless experience for customers (User) and administrators (Admin) to browse and purchase sunglasses and power glasses, manage orders, and handle inventory and customer information.

## User Role

- **Google Login**: Secure login using a Google account for seamless access to the application.
- **Product Search**: Browse and filter sunglasses and power glasses based on categories, price, and preferences.
- **Virtual Try-On**: Users can virtually try on glasses before making a purchase.
- **Cart & Checkout**: Add products to the cart, review orders, and proceed to checkout.
- **Order History**: View and manage personal order history.
- **Profile Management**: Update personal details, addresses, and payment methods.

## Technologies

- **Flutter**: Core framework for building the mobile application.
- **Provider**: State management for handling complex state across various components.
- **Flutter UI Toolkit**: Custom widgets and UI components for a consistent and responsive user interface.

## API Integration

The mobile application communicates with the backend via a RESTful API, handling operations for both Admin and User roles, such as product management, order processing, and customer data handling.

## Future Works

- **Enhanced Personalization**: Implement AI-driven recommendations based on user preferences and past behavior to suggest glasses more accurately.
- **In-Store Pickup Option**: Introduce an option for users to reserve glasses online and pick them up at a physical store location.
- **Social Media Integration**: Enable users to share their virtual try-on experiences and favorite glasses directly on social media platforms.

## Challenges

- **State Management**: Managing complex state across various components, particularly with features like virtual try-on, user authentication, and shopping cart, was challenging but effectively handled using Provider and ChangeNotifier. Riverpod was also utilized.
- **Responsive Design**: Ensuring that the user interface remained consistent and functional across a wide range of devices and screen sizes was challenging, but Flutter's flexible layout system provided the tools needed to create a responsive design.
- **API Integration**: Handling API requests for real-time product updates, user authentication, and AR data processing while maintaining smooth and secure communication was crucial and required thorough testing.

## Environment Variables

- `FLUTTER_APP_API_URL`: `http://localhost:5000`
- `FLUTTER_APP_GOOGLE_CLIENT_ID`:`348505927725-cr4r7icrbji1gavs54r10etnojn911c8.apps.googleusercontent.com`
- `FLUTTER_APP_KHALTI_URL`: `https://test-pay.khalti.com/`
- `FLUTTER_APP_KHALTI_PUBLIC_KEY`: `723a1de3679647e2993b8537e48ec876`

## Getting Started

### Prerequisites

- **Flutter SDK**
- **Dart SDK**
- **Android Studio** or **Xcode**
- A valid **Google API Client ID** for authentication
- **Khalti payment gateway** integration
