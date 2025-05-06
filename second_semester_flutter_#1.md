## 4.5 Mobile Application  

### 4.5.1 Introduction  
The Savebite mobile application serves as the primary interface for users to manage their food sustainability effectively. Built using Flutter, the application leverages a modern and efficient framework enabling seamless cross-platform development, allowing for a smooth experience on both iOS and Android devices.  

This section discusses the key technologies and architectural patterns used in the development of the mobile application.  

### 4.5.2 Framework: Flutter   
Flutter is an open-source UI toolkit developed by Google that allows developers to create natively 
compiled applications from a single codebase. The choice of Flutter for CashWise was driven by several 
advantages: 
- **Cross-Platform Compatibility**: Flutter enables the development of applications for both iOS and 
Android platforms without the need to maintain separate codebases, significantly reducing 
development time and effort. 

- **Rich UI Components**: Flutter provides a wide range of pre-designed widgets that facilitate the 
creation of visually appealing and responsive user interfaces, enhancing the overall user 
experience.

### 4.5.3 State Management: BLoC (Cubit)  
To manage the state of the application effectively, the BLoC (Business Logic Component) pattern was 
employed, specifically using the Cubit implementation. This approach offers several benefits: 
- **Separation of Concerns**: By separating business logic from the UI, the BLoC pattern promotes 
cleaner code and easier maintenance. This separation allows developers to focus on the UI while 
managing the application state independently. 

- **Reactive Programming**: The BLoC pattern enables reactive programming, allowing the UI to 
respond to changes in the application state in real-time. This ensures that users receive 
immediate feedback based on their interactions.

### 4.5.4 Local Storage: Hive 
For local data storage, Hive was chosen as the database solution. Hive is a lightweight and fast NoSQL database that is well-suited for Flutter applications. Its advantages include: 
- **Performance**: Hive is optimized for performance, providing fast read and write operations, which 
is essential for a responsive user experience. 

- **Ease of Use**: The simple API of Hive makes it easy to implement and manage local data storage, 
allowing developers to focus on building features rather than dealing with complex database 
management. 

### 4.5.5 Networking: Dio 
Dio is a powerful HTTP client for Dart that was utilized for making network requests in the Savebite
application. Key features of Dio include: 
- **Interceptors**: Dio allows the use of interceptors to handle requests and responses globally, making it easier to manage authentication tokens, logging, and error handling. 

- **Form Data and File Uploads**: Dio supports multipart form data and file uploads, which is 
essential for features like scanning receipts and uploading images. 

### 4.5.6 Responsive Design 
flutter_screenutil and MediaQuery 
To ensure that the application provides a consistent and responsive user experience across different 
screen sizes and orientations, the following tools were used: 
- **flutter_screenutil**: This package allows developers to create responsive layouts by adapting the UI to different screen sizes. It simplifies the process of scaling dimensions and fonts based on 
the device's screen size, ensuring that the application looks great on all devices. 

- **MediaQuery**: Flutter's built-in MediaQuery class was used to obtain information about the 
device's screen size and orientation. This information was leveraged to adjust the layout 
dynamically, providing a tailored experience for users.

### 4.5.7 Technologies Used

The Flutter frontend is developed with a focus on performance, scalability, and a consistent user experience across platforms. The key technologies used in this project include:

| **Technology**               | **Description**                                                                 |
|-----------------------------|---------------------------------------------------------------------------------|
| **Flutter**                 | UI toolkit for building natively compiled apps for mobile, web, and desktop.   |
| **BLoC (bloc, flutter_bloc)** | State management pattern using reactive streams and events.                    |
| **Dio**                     | A powerful HTTP client for Dart, used for making network requests.              |
| **Hive & hive_flutter**     | Lightweight, NoSQL local database solution for Flutter.                        |
| **fl_chart**                | Library for creating beautiful and customizable charts (used for stats).       |
| **flutter_screenutil**      | A screen adaptation tool for building responsive UIs.                          |
| **image_picker**            | Allows picking images from the gallery or camera.                              |
| **internet_connection_checker** | Checks for internet connectivity status.                                |


### 4.5.8 Features Implemented 

#### 4.5.8.1 User Authentication
SaveBite includes a secure authentication system that supports email-based login and image-based verification. The process ensures that users can access the platform securely and efficiently.

#### 4.5.8.2 User Registration (Sign Up)
New users can register through a streamlined sign-up process that collects essential details such as name, email, password, and profile image. The system validates user input and initiates OTP-based verification for secure onboarding.

#### 4.5.8.3 OTP Verification
SaveBite implements OTP-based verification to enhance the security of sensitive operations, such as user sign-up, login validation, and account recovery. The OTP is sent via email and must be confirmed within a limited time window.

#### 4.5.8.4 Resend OTP
In case users do not receive or lose their OTP, a Resend OTP feature is available to regenerate and deliver a new code, ensuring uninterrupted access to the verification process.

#### 4.5.8.5 Account Recovery
For users who forget their credentials, SaveBite provides an account recovery process via security questions or OTP validation, helping them regain access safely and easily.


#### 4.5.8.6 Home  
Displays a stock summary dashboard and allows users to upload product data files. It supports sorting, adding new items, and displays data in a structured table.

- **Input**: Product data file (e.g., Excel , CSV).  
- **Output**: Stock metrics (e.g., total stock, below par/minimum items) and product table.


#### 4.5.8.7 Stock  
Visualizes reorder quantities over 4 weeks using a line chart and a data table. Includes search and filter options by product name and category.

- **Input**: Stock data.  
- **Output**: Chart and table of reorder quantities.


#### 4.5.8.8 Analytics  
Provides sales and stock forecasts for the next 4 weeks, including turnover rate, reorder accuracy, revenue, and overstocking by category.

- **Output**: Predicted stock/sales metrics and overstock breakdown.


#### 4.5.8.9 Chatbot  
AI-powered assistant that suggests and creates recipes using leftover ingredients. Supports message history and favorites.

- **Features**: Recipe generation, chat history, favorite messages.


### 4.5.9 System Design 

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image.png" alt="Splash Screen" width="200">
    <p><b>Figure 4.5.9.1:</b> Splash Screen – Displays the app logo before launching the app.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-1.png" alt="Login Screen" width="200">
    <p><b>Figure 4.5.9.2:</b> Login Screen (Image-Based) – Login using email and image verification.</p>
  </div>
  <div>
    <img src="markdown assets\image-3.png" alt="Login Screen" width="200">
    <p><b>Figure 4.5.9.3:</b> Login Screen (Password-Based) – Allows users to log in using email and password.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-4.png" alt="Forget Password" width="200">
    <p><b>Figure 4.5.9.4:</b> Forget Password Screen – User answers a security question set during sign-up.</p>
  </div>
  <div>
    <img src="markdown assets\image-5.png" alt="Verification" width="200">
    <p><b>Figure 4.5.9.5:</b> OTP Verification Screen – Users receive OTP via email for identity verification.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-8.png" alt="Loading" width="200">
    <p><b>Figure 4.5.9.6:</b> Loading Screen – Displays Loading state to return a successful state or not.</p>
  </div>
  <div>
    <img src="markdown assets\image-6.png" alt="Reset Password" width="200">
    <p><b>Figure 4.5.9.7:</b> Reset Password Screen – Confirms success of the password reset process.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-7.png" alt="Sign up" width="200">
    <p><b>Figure 4.5.9.8:</b> Sign up Screen – Collects email, password, image, username, phone number, account type, and a security question.</p>
  </div>
</div>

<br><br>


<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-9.png" alt="Home First Time Screen" width="200">
    <p><b>Figure 4.5.9.9:</b> Home First-Time Screen – Displays table headers and search field.</p>
  </div>

  <div>
    <img src="markdown assets\image-11.png" alt="Home" width="200">
    <p><b>Figure 4.5.9.10:</b> Home Screen – Shows stock summary and uploaded product table.</p>
  </div>
</div>

<br>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-12.png" alt="Home Filter" width="200">
    <p><b>Figure 4.5.9.11:</b> Home Filter Screen – Allows sorting based on stock characteristics.</p>
  </div>

  <div>
    <img src="markdown assets\image-13.png" alt="Home Add Item" width="200">
    <p><b>Figure 4.5.9.12:</b> Add Item Screen – Prompts user to enter characteristics of a new product.</p>
  </div>
</div>

<br>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-14.png" alt="Home Final" width="400">
    <p><b>Figure 4.5.9.13:</b> Home Screen – Final view with stock information and table displayed.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-15.png" alt="Stock" width="200">
    <p><b>Figure 4.5.9.14:</b> Stock Screen – Displays reorder quantities using a line chart along with a data table.</p>
  </div>

  <div>
    <img src="markdown assets\image-16.png" alt="Stock Filter" width="200">
    <p><b>Figure 4.5.9.15:</b> Stock Filter Screen – Allows users to filter products by search or checkbox selection.</p>
  </div>

  <div>
    <img src="markdown assets\image-17.png" alt="Stock Filter Applied" width="200">
    <p><b>Figure 4.5.9.16:</b> Stock Filter Applied Screen – Shows filtered product data rendered on the chart.</p>
  </div>
</div>
<br> <br>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-19.png" alt="Analytics" width="200">
    <p><b>Figure 4.5.9.16:</b> Analytics Screen – Visualizes predicted stock levels for the next 4 weeks using a line chart.</p>
  </div>

  <div>
    <img src="markdown assets\image-20.png" alt="Analytics Filter" width="200">
    <p><b>Figure 4.5.9.17:</b> Analytics Filter Screen – Allows users to filter forecast data by category before rendering the chart.</p>
  </div>
</div>
<br> <br>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-21.png" alt="Chatbot First Time" width="200">
    <p><b>Figure 4.5.9.18:</b> Chatbot First-Time Screen – Displays a helpful prompt for users to initiate a query.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-26.png" alt="Chatbot English" width="200">
    <p><b>Figure 4.5.9.19:</b> Chatbot Screen – Displays a recipe response in English.</p>
  </div>

  <div>
    <img src="markdown assets\image-25.png" alt="Chatbot Arabic" width="200">
    <p><b>Figure 4.5.9.20:</b> Chatbot Screen – Displays a recipe response in Arabic.</p>
  </div>
</div>

<div style="display: flex; justify-content: center; gap: 40px; text-align: center;">
  <div>
    <img src="markdown assets\image-27.png" alt="Chatbot Favorites" width="200">
    <p><b>Figure 4.5.9.21:</b> Chatbot Favorites Screen – Shows saved or favorite recipe responses.</p>
  </div>
</div>


### 4.5.10 User Flow



### 4.5.11 Code

The full source code for the SaveBite mobile application is publicly available on GitHub at:  
🔗 [SaveBite Flutter Repository](https://github.com/SaveBite/SaveBite-Flutter/tree/main)

#### Project Structure Overview

The application follows the **Clean Architecture** pattern to separate concerns across multiple layers. Below is a high-level breakdown of the folder structure inside the `lib` directory:

```
lib/
├── core/                     # Core utilities (constants,       errors, helpers, services)
│   ├── constants/
│   ├── error/
│   ├── services/
│   └── utils/
│
├── features/                 # Feature-based modules (e.g., authentication, home, stock)
│   ├── auth/                 # User authentication flows
│   │   ├── data/             # API and data models
│   │   ├── domain/           # Entities and repositories
│   │   └── presentation/     # UI widgets and screens
│   │
│   ├── home/
│   ├── stock/
│   ├── analytics/
│   └── chatbot/
│
├── config/                   # Global configurations like themes and routes
│
└── main.dart                 # Application entry point
```

Each feature (e.g., `auth`, `home`, `stock`,`chatbot`,`analytics`) is divided into:
- `data`: Remote sources, models, Repo implementations.
- `domain`: Repositories, entities, and use cases.
- `presentation`: Screens, Blocs, widgets, and UI logic.

This modular structure ensures **testability**, **scalability**, and **easy maintenance** as the app grows.
