import 'package:flutter/material.dart';
import 'package:notifications/screens/home_screen.dart';
import 'package:notifications/screens/mesaje_screenh.dart';
import 'package:notifications/services/push_notifications_services.dart';
 
void main() async{
  // prepara un context para solucionar un error
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() { 
    super.initState();
    PushNotificationService.messageStream.listen((message) {
      print('My App  : $message');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (_)=> HomeScreen(),
        'message': (_)=>MessageScreen(),
      },
    );
  }
}