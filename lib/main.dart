import 'package:flutter/material.dart';
import 'package:flutter_project/data/models/HomePageModel.dart';
import 'package:flutter_project/data/models/User.dart';
import 'package:flutter_project/view/Login/ProfileForm.dart';
import 'package:flutter_project/view/Login/loginscreen.dart';
import 'package:flutter_project/view/MainRoutes/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()), 
        ChangeNotifierProvider(create: (_) => HomePageModel()), 
        ChangeNotifierProvider(create: (_) => Profile(token: 'hello', userId: 12,)),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    print("helllllllllllo");
    return MaterialApp(
      theme: ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: Colors.white,),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,),
        textTheme: TextTheme(
          bodySmall: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
        ),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF437e76),
          onPrimary: Colors.white,
          tertiary: Color.fromARGB(255, 222, 208, 150),
          onTertiary: Colors.white,
          secondary:Color(0xFF74a29c),
        
        )
        ),
      home: Homepage(token: "hello"),
      // home: Homepage(token: context.read<Profile>().token,),
    );
  }
}
