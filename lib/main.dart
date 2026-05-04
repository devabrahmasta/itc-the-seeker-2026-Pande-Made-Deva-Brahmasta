import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Wajib di-import
import 'package:itc_directory/pages/main_screen.dart';
import 'package:itc_directory/providers/member_provider.dart';
import 'package:itc_directory/services/fav_service.dart'; // Wajib di-import
import 'package:itc_directory/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => FavService(prefs)),
        ChangeNotifierProvider(
          create: (context) => MemberProvider(context.read<FavService>()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITC Directory',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
