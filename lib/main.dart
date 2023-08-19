import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controller/user_controller.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sport_partner/view/pages/splash_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.defaultTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
