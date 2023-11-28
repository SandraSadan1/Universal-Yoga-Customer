import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/utils/Constants.dart';
import 'package:universal_yoga/utils/helpers/Helpers.dart';
import 'package:universal_yoga/views/static/SplashScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CONSTANTS constants = CONSTANTS();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Helpers()),
      ],
      child: MaterialApp(
        title: constants.title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ConstantColors.appBg,
          colorScheme: ColorScheme.fromSeed(
            seedColor: ConstantColors.appBg,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          textTheme: TextTheme(
            bodyMedium: GoogleFonts.lora(),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
