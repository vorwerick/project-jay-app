# Firebase in Flutter

- [Codelab: Get to know Firebase for Flutter](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)
- [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=android)
- [Send a test message to a backgrounded app](https://firebase.google.com/docs/cloud-messaging/flutter/first-message)
- [Cloud messaging usage](https://firebase.flutter.dev/docs/messaging/usage)
- [Notifications](https://firebase.flutter.dev/docs/messaging/notifications/)
- [Receive messages in a Flutter app](https://firebase.google.com/docs/cloud-messaging/flutter/receive)
- [Firebase examples](https://github.com/firebase/flutterfire/tree/master/packages/firebase_messaging/firebase_messaging/example)
- [Flutter + Firebase Push Notifications (Complete Guide)](https://medium.com/@ChanakaDev/flutter-firebase-push-notifications-complete-guide-fae42c88f32a)


Some of the notes is from original documentation

---

## Firebase core

Add dependency to firebase core

```bash
flutter pub add firebase_core
```

Download and install firebase cli
- [Firebase CLI reference](https://firebase.google.com/docs/cli#linux)

```bash
curl -sL https://firebase.tools | bash
```

Login to your firebase account

```bash
firebase login
```

View projects from firebase

```bash
firebase projects:list
```


FlutterFire is a set of Flutter plugins which connect your Flutter application to [Firebase](https://firebase.com/).

Flutterfire cli depends on firebase cli

Activate flutterfire

```bash
dart pub global activate flutterfire_cli
```

You may need to export path to bin

```bash
export PATH="$PATH":"$HOME/.pub-cache/bin"

```

Configure your project

```bash
flutterfire configure
```

Init firebase

```Dart
await Firebase.initializeApp(  
	options: DefaultFirebaseOptions.currentPlatform,  
);
```

---

## Cloud messaging

### Handling Interaction

Since notifications are a visible cue, it is common for users to interact with them (by pressing). The default behavior on both Android and iOS is to open the application. If the application is terminated it will be started; if it is in the background it will be brought to the foreground.

Depending on the content of a notification, you may wish to handle the user's interaction when the application opens. For example, if a new chat message is sent via a notification and the user presses it, you may want to open the specific conversation when the application opens.

The `firebase-messaging` package provides two ways to handle this interaction:

- `getInitialMessage()`: If the application is opened from a terminated state a `Future` containing a `RemoteMessage` will be returned. Once consumed, the `RemoteMessage` will be removed.
- `onMessageOpenedApp`: A `Stream` which posts a `RemoteMessage` when the application is opened from a background state.

```dart
// Get any messages which caused the application to open from
// a terminated state.
RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

// If the message also contains a data property with a "type" of "chat",
// navigate to a chat screen
if (initialMessage != null) {
   _handleMessage(initialMessage);
}

// Also handle any interaction when the app is in the background via a
// Stream listener
FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      Navigator.pushNamed(context, '/chat',
        arguments: ChatArguments(message),
      );
    }
  }
```

Show token

```dart
final String? fcmToken = await FirebaseMessaging.instance.getToken();
log('Firebase cloud messaging token: ${fcmToken ?? 'null'}');
```

To handle messages while your application is in the foreground, listen to the `onMessage` stream.

```dart
FirebaseMessaging.onMessage.listen((RemoteMessage message){
log('Got a message whilst in the foreground!'); 
log('Message data: ${message.data}');
if (message.notification != null) {
	log('Message also contained a notification:${message.notification}');
	}
});
```

### Background messages

The process of handling background messages is different on native (Android and Apple) and web based platforms.

#### Apple platforms and Android

Handle background messages by registering a `onBackgroundMessage` handler. When messages are received, an isolate is spawned (Android only, iOS/macOS does not require a separate isolate) allowing you to handle messages even when your application is not running.

There are a few things to keep in mind about your background message handler:

1. It must not be an anonymous function.
2. It must be a top-level function (e.g. not a class method which requires initialization).
3. When using Flutter version 3.3.0 or higher, the message handler must be annotated with `@pragma('vm:entry-point')` right above the function declaration (otherwise it may be removed during tree shaking for release mode).

```dart
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}
```


---
## Crashlytics

- [Get started with Firebase Crashlytics](https://firebase.google.com/docs/crashlytics/get-started?platform=flutter)
- [Using Firebase Crashlytics](https://firebase.flutter.dev/docs/crashlytics/usage)

Add dependency to project
```bash
flutter pub add firebase_crashlytics
```

```dart
// init
 await Firebase.initializeApp();
 
 // Pass all uncaught "fatal" errors from the framework to Crashlytics  
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
PlatformDispatcher.instance.onError = (error, stack){
	FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
	return true;
};
```