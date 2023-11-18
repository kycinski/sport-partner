import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sport_partner/controllers/chats_controller.dart';
import 'package:sport_partner/controllers/sport_categories_provider.dart';
import 'package:sport_partner/controllers/user_controller.dart';
import 'package:sport_partner/services/city_service.dart';
import 'package:sport_partner/services/sport_categories_service.dart';
import 'package:sport_partner/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sport_partner/view/pages/select_city_page.dart';
import 'package:sport_partner/view/pages/sport_categories_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sportCategoriesJsonData = await SportCategoriesService().fetchSportCategories();
  final isAnyCitySelected = await CityService().checkIfCityIsSelected();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('pl', 'PL')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(sportCategoriesJsonData, isAnyCitySelected),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp(this.sportCategoriesJsonData, this.isAnyCitySelected, {super.key});

  final Map<String, dynamic> sportCategoriesJsonData;
  final bool isAnyCitySelected;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(
          create: (_) => SportCategoriesProvider(
            sportCategoriesJsonData,
            context.locale.languageCode,
          ),
        ),
        ChangeNotifierProvider(create: (_) => ChatsController()),
      ],
      child: MaterialApp(
        title: 'Sport Partner',
        theme: AppTheme.defaultTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
        home: isAnyCitySelected ? const SportCategoriesPage() : const SelectCityPage(),
      ),
    );
  }
}
