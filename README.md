Task Manager "Taskify” 

## Task Manager "Taskify” - Project Description:
"Introducing Taskify- Your Ultimate Task Management Companion! With a captivating splash screen, seamless login and signup processes, and email verification via OTP for added security, Taskify ensures a smooth onboarding experience. Once you're in, your user token is securely stored with SharedPreferences, allowing convenient access without repeated logins.
Task creation, editing, deletion, and updates are a breeze, and all changes reflect dynamically on the home page. Taskifyalso lets you monitor task progress with intuitive status indicators. Forgot your password? No worries! The app offers a hassle-free password reset option. Plus, you can update your profile without the need for an email confirmation. With a robust REST API integration, TaskSwift fetches data effortlessly, ensuring real-time access to your task-related information.
Stay organized with ease thanks to the user-friendly bottom navigation bar, providing quick access to four key sections: New Task, Progress, Cancelled, and Completed Tasks. Boost your productivity and task management prowess with Taskify!"

## Technologies:
## 1.	Flutter Framework: Taskify is built using the Flutter framework, allowing for cross-platform development and a consistent user experience across Android and iOS devices.
## 2.	SharedPreferences: User tokens are securely stored in SharedPreferences to enable seamless access without requiring users to log in repeatedly.
## 3.	REST API Integration: Taskify integrates with a robust REST API to fetch and update task-related data in real-time.

## JWT Token Usage:
## 1.	User Authentication: When a user logs in successfully, the server generates a JWT token and sends it back to the client (Flutter app) as part of the login response.
## 2.	Token Storage: The Flutter app securely stores this JWT token in SharedPreferences. This token serves as proof of the user's identity and is used to authenticate subsequent API requests.
## 3.	Token Inclusion: For every API request that requires authentication, the Flutter app includes the JWT token in the request headers. This informs the server that the request is coming from an authenticated user.
## 4.	Token Verification: On the server side, the JWT token is verified to ensure its authenticity and validity. If the token is valid, the requested action (e.g., creating, editing, or deleting a task) is executed.
 
## Features:

## 1.	Splash Screen: Taskify features a captivating splash screen that enhances the app's initial impression.
## 2.	Login and Signup: The app offers a seamless login and signup process, ensuring a smooth onboarding experience for users.
## 3.	Email Verification via OTP: For added security, users verify their email addresses using OTP during the initial login.
## 4.	Task Management: Users can create, edit, delete, and update tasks with ease, and all changes are reflected dynamically on the home page.
## 5.	Task Progress Tracking: Taskify includes intuitive status indicators to monitor task progress effectively.
## 6.	Password Reset: Users who forget their passwords can easily reset them through a hassle-free password reset feature.
## 7.	Profile Update: Users can update their profiles without requiring email confirmation, enhancing user convenience.
## 8.	Bottom Navigation Bar: Taskify features a user-friendly bottom navigation bar, offering quick access to four key sections: New Task, Progress, Cancelled, and Completed Tasks.

## ScreenShots
![task](https://github.com/sajibmalek/Task-Manager-/assets/44054338/70a0037d-9fca-4304-bd78-1b8c231d8ed9)





