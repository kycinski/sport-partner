import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pl', 'PL')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        home: const SplashScreen(),
      ),
    );
  }
}
