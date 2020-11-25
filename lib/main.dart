import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.red,
        primaryColor: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('noisefit');
    var iOSinitialize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: androidInitialize,
      iOS: iOSinitialize,
    );
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      'Channel ID',
      'Notif',
      'New Channel',
      importance: Importance.max,
      autoCancel: false,
      fullScreenIntent: true,
      visibility: NotificationVisibility.public,
      // category: 'Text',
      icon: 'noisefit',
      color: Color(0xFF24242E),
      maxProgress: 20,
      indeterminate: true,
      ongoing: true,
      progress: 10,
      showProgress: true,
      styleInformation: BigTextStyleInformation(''),
      showWhen: true,
      when: 1,
      // indeterminate: true,
      // color: Colors.black
    );
    var iOSDetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await fltrNotification.show(
        0, 'NoiseFit', 'Running In Background ', generalNotificationDetails,
        payload: "Task");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FloatingActionButton(
          onPressed: _showNotification,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {}
}
