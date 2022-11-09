import 'package:diy/diy.dart';
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:diy/utils/theme_files/app_themes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final diy = FlutterDIY();
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.background(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor(context),
                ),
                child: const Center(
                    child: Center(
                        child: Text('Hello this is Sample APP',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)))),
              ),
              ElevatedButton(
                onPressed: () {
                  diy.init(context);
                },
                child: const Text('Go to Main Screen'),
              ),
            ],
          ),
        ),
      ),
      title: 'blinktrade',
      themeMode: ThemeMode.system, // Default
      theme: appThemes[ThemeMode.light],
      darkTheme: appThemes[ThemeMode.dark],
    );
  }
}
