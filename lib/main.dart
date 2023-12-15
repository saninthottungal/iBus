import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ibus2/Database/DatabaseFunctions.dart';
import 'package:ibus2/Database/DatabaseModel.dart';
import 'package:ibus2/Screens/ScreenAdmin.dart';
import 'package:ibus2/Screens/ScreenEmailVerify.dart';
import 'package:ibus2/Screens/ScreenForgotPassword.dart';
import 'package:ibus2/Screens/ScreenGreet.dart';
import 'package:ibus2/Screens/ScreenHome.dart';
import 'package:ibus2/Screens/ScreenSignUp.dart';
import 'package:ibus2/Screens/ScreenSignin.dart';
import 'package:ibus2/Screens/ScreenSplash.dart';
import 'package:ibus2/Screens/ScreenVerifyAdmin.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (!Hive.isAdapterRegistered(BusModelAdapter().typeId)) {
    Hive.registerAdapter(BusModelAdapter());
  }
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: themeColor),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: const ScreenSplash(),
      routes: {
        "splash": (context) => const ScreenSplash(),
        "signin": (context) => ScreenSignIn(),
        "signup": (context) => ScreenSignUp(),
        "greet": (context) => const ScreenGreet(),
        "home": (context) => const ScreenHome(),
        "mail": (context) => const ScreenEmailVerify(),
        "admin": (context) => ScreenAdmin(),
        "verifyAdmin": (context) => ScreenVerifyAdmin(),
        "forgot": (context) => ScreenForgotPassword(),
      },
    );
  }
}
