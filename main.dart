import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; // Import Provider

import 'package:newapp/pages/splashscreen.dart';
import 'package:newapp/pages/homepage.dart';
import 'package:newapp/pages/user_select_page.dart';
import 'package:newapp/pages/businesshome.dart';
import 'package:newapp/pages/businessprofile.dart';
import 'package:newapp/pages/salespage.dart';
import 'package:newapp/pages/otppage.dart';
import 'package:newapp/pages/scemespage.dart';
import 'package:newapp/pages/salesprofile.dart';
import 'package:newapp/pages/customerhome.dart';
import 'package:newapp/pages/myorderpage.dart';
import 'package:newapp/pages/customerprofile.dart';
import 'package:newapp/pages/customerprofilesetup.dart';
import 'package:newapp/language_provider.dart'; // Import your LanguageProvider
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🚨 Firebase setup for Web and Mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }

  // Initialize LanguageProvider
  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguageData();

  runApp(
    ChangeNotifierProvider(
      create: (context) => languageProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gramakart',
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(child: LoginPage()),
      routes: {
        '/authpage': (context) => const OTPVerifyPage(
              verificationId: 'dummy-id',
              phoneNumber: '0000000000',
            ),
        '/chooseUser': (context) => const UserSelectionPage(),
        '/businesslogin': (context) => const BusinessProfilePage(),
        '/businessprofile': (context) {
          final docId = ModalRoute.of(context)!.settings.arguments as String;
          return BusinessProfileSetupPage(docId: docId);
        },
        '/sales': (context) {
          final docId = ModalRoute.of(context)!.settings.arguments as String;
          return SalesPages(docId: docId);
        },
        '/schemes': (context) {
          final docId = ModalRoute.of(context)!.settings.arguments as String;
          return SchemesPages(docId: docId);
        },
        '/profile': (context) {
          final docId = ModalRoute.of(context)!.settings.arguments as String;
          return SalesProfiles(docId: docId);
        },
        '/customerhome': (context) => const CustomerHomePage(),
        '/myorderpage': (context) => const MyOrdersPage(),
        '/customerprofile': (context) => const ConsumerProfilePage(),
        '/customerprofilesetup': (context) => const ConsumerProfilesetup()
      },
    );
  }
}