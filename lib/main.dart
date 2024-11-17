import 'package:firebase_core/firebase_core.dart';
import 'package:flashcard/screens/controllerscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlashCard',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlueAccent
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.lightBlueAccent[600]
        )
      ),
      debugShowCheckedModeBanner: false,
      home: const Controllerscreen(),
    );
  }
}