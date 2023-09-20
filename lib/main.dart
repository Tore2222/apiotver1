import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iotappver1/src/ServiceMQTT/MQTTManager.dart';
import 'package:iotappver1/src/ServiceMQTT/variable_app.dart';
import 'package:iotappver1/src/app.dart';
import 'package:iotappver1/src/resources/widget/screens/Test_Screen.dart';
import 'package:iotappver1/src/resources/widget/screens/config_wifi.dart';
import 'package:iotappver1/src/resources/widget/screens/homepage.dart';
import 'package:iotappver1/src/resources/widget/screens/login_page.dart';
import 'package:iotappver1/src/resources/widget/thungrac/qr.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppData(),
      child: Myapp(
          // new AuthBloc(),
          const MaterialApp(home: HomePage())),
    ),
  );
}
