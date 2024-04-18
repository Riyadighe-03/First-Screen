import 'package:firstscreen/foreground_notification.dart';
import 'package:firstscreen/notification.dart';
import 'package:flutter/material.dart';
import 'package:firstscreen/app_bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('Notification Message: ${message.data}');
  NotificationService.showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
          options: const FirebaseOptions(
              appId: '1:904494419924:android:cf5b3245127ce7ba80d041',
              apiKey: 'AIzaSyDnxDqHkfQDc-jgADfRbDlnsBm_kGmwVVM',
              messagingSenderId: '904494419924',
              projectId: 'firstscreen-4ac8e',
              storageBucket: "firstscreen-4ac8e.appspot.com"))
      .then((value) => print("Successfull"))
      .then((value) => debugPrint("firebase initialised"));
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  NotificationService.initialize();
  PushNotification().initialize();

  runApp(const MyApp());
}

Future<void> onBackgroundMessageHandler(message) async {
  print("onBackgroundMessage: $message");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //final MyApp appBloc = BlocProvider.of<AppBloc>(context);
  final AppBloc appBloc = AppBloc();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  //final PushNotification _notificationService = PushNotification();

  @override
  void initState() {
    super.initState();
    // setupFirebaseMessaging();
    appBloc.add(IncrementEvent(0));
    const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    // );
    /* NotificationService.initialize();
    // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    //   alert: true,
    //   badge: true,
    //   sound: true,
    );*/
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   NotificationService.showNotification(message);
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext dialogContext) => AlertDialog(
    //       content: Text(message.notification?.body ?? "No body"),
    //       title: Text(message.notification?.title ?? "No Title"),
    //     ),
    //   );
    // });
  }

  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotificationSnackBar(message);
    });
  }

  void showNotificationSnackBar(RemoteMessage message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.notification?.body ??
              'You received a notification with no body.',
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 8),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            setupFirebaseMessaging();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // _notificationService.initialize();
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(leading: Icon(Icons.close), actions: [
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Text(
                "Buy gift cards",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ]),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: 350,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.lightBlue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.play_arrow_outlined),
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      "Google play gift card",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("\$10-\$200",
                        style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
                alignment: Alignment.bottomLeft,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const RotatedBox(
                        quarterTurns: -1,
                        child: Text("Select option",
                            style: TextStyle(color: Colors.grey))),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text("Select size",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<AppBloc, AppState>(
                              bloc: appBloc,
                              builder: (context, state) {
                                if (state is UpdatedState) {
                                  return Row(children: [
                                    ElevatedButton(
                                      onPressed: () => appBloc
                                          .add(DecrementEvent(state.count - 1)),
                                      child: const Text("-",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "${state.count}",
                                      style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    ElevatedButton(
                                      onPressed: () => appBloc
                                          .add(IncrementEvent(state.count + 1)),
                                      child: const Text(
                                        "+",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ]);
                                }
                                return SizedBox();
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("Select store",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/america.jpg",
                                    height: 30, width: 30),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/india.webp",
                                    height: 30, width: 30),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: Image.asset("assets/south_Africa.png",
                                    height: 30, width: 30),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "Select size",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        Text(
                          "\$104.50",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 90,
                    ),
                    Container(
                      height: 75,
                      width: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.lightBlue,
                      ),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
