# shinex

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Absolutely, Chantal! Below is a complete and professional **README.md** file for your Flutter note-taking app project. It includes:

* Project description
* Features
* Firebase integration steps
* State management (BLoC)
* Project structure
* How to run the app
* How to test it
* Credits

You can copy this into your `README.md` on GitHub or your local project.

---

````markdown
# 📝 Flutter Notes App with Firebase

A simple note-taking mobile app built with **Flutter**, integrated with **Firebase Authentication** and **Cloud Firestore**, using **BLoC (Business Logic Component)** for state management. Users can sign up, sign in, and manage personal notes (create, read, update, delete).

---

## 📱 Features

- Email & Password Authentication (Firebase Auth)
- Add, view, edit, and delete notes
- Notes saved per authenticated user in Firestore
- Fully responsive UI (portrait & landscape)
- Clean architecture using BLoC
- SnackBar error/success feedback
- Loader for async operations
- Logout support

---

## 🛠️ How the App Was Built

### 🔧 Project Setup

1. Created a new Flutter project:
   ```bash
   flutter create notes_app
````

2. Installed Firebase and required dependencies:

   ```yaml
   firebase_core
   firebase_auth
   cloud_firestore
   flutter_bloc
   equatable
   ```

3. Configured Firebase:

   * Created Firebase project via [Firebase Console](https://console.firebase.google.com/)
   * Enabled **Email/Password Auth**
   * Initialized **Cloud Firestore**
   * Ran:

     ```bash
     dart pub global activate flutterfire_cli
     flutterfire configure
     ```

4. Added `google-services.json` to `android/app/`

---

### 🧠 State Management: BLoC Pattern

I used **flutter\_bloc** for managing authentication and notes logic.

* `AuthBloc`: Handles sign in, sign up, and sign out
* `NotesBloc`: Handles create, read, update, delete operations for notes
* UI updates automatically via `BlocBuilder`

All business logic is separated from the UI, improving maintainability and scalability.

---

### 🗂️ Folder Structure

```
lib/
├── bloc/               # BLoCs for auth and notes
│   ├── auth_bloc.dart
│   ├── auth_event.dart
│   ├── auth_state.dart
│   ├── notes_bloc.dart
│   ├── notes_event.dart
│   └── notes_state.dart
├── models/             # Data models like Note
├── providers/          # Firebase providers (optional abstraction)
├── repositories/       # Auth and Firestore CRUD logic
├── screens/            # UI screens (auth & notes)
├── widgets/            # Reusable widgets
├── firebase_options.dart  # Firebase config (auto-generated)
└── main.dart           # Entry point
```

---

## 🚀 How to Run the App

### 🔨 Prerequisites

* Flutter SDK (3.8 or higher)
* Firebase CLI
* Android Studio or emulator
* Dart SDK 3.8.1+

### 🧪 Steps

1. Clone the repo:

   ```bash
   git clone https://github.com/your-username/flutter-notes-app.git
   cd flutter-notes-app
   ```

2. Get dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run -d emulator-5554
   ```

> ⚠️ Make sure `firebase_options.dart` is correctly generated and imported in `main.dart`.

---

## 🔐 Firebase Firestore Structure

```
users (collection)
 └── [uid] (document)
      └── notes (sub-collection)
           ├── [noteId1]
           │    └── text, createdAt, updatedAt
           └── [noteId2]
                └── ...
```

Each user's notes are saved in their own sub-collection using their Firebase UID.

---

## 🐞 Error Handling & Fixes

I encountered and resolved the following:

* Dart SDK version mismatch (`flutter upgrade`)
* Android NDK version conflict (`ndkVersion` in `build.gradle.kts`)
* Emulator ADB offline (`adb kill-server && adb start-server`)
* Firebase `[CONFIGURATION_NOT_FOUND]` (re-run `flutterfire configure`)
* Vulkan rendering issues (ignored non-blocking logs)




`
