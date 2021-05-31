import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static FirebaseMessaging messagin = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController();
  static Stream<String> get messageStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async{
    // print('background Handler ${message.messageId}');
    _messageStream.add(message.notification?.body??'No Title');
  }
  static Future _onMessageHandler(RemoteMessage message) async{
    // print('OnMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body??'No Title');
  }
  static Future _onMessageOpenApp(RemoteMessage message) async{
    // print('onMessageOpenApp Handler ${message.messageId}');
    _messageStream.add(message.notification?.body??'No Title');
  }

  static Future initializeApp() async {
    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);
    // Local notificaiotions
  }
  static closeStreams(){
    _messageStream.close();
  }
}