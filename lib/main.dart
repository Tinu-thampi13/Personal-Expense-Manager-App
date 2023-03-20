import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iota/models/category/category_model.dart';
import 'package:iota/models/transaction/transaction_model.dart';
import 'package:iota/screens/home/home_screen.dart';
import 'package:iota/screens/transaction/widgets/add_transactions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isdark = true;
  void setIsDark() {
    setState(() {
      isdark = !isdark;
    });
  }

  ThemeData _lightTheme = ThemeData(
    primaryColor: Colors.grey[100],
    brightness: Brightness.light,
  );

  ThemeData _darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: isdark ? _darkTheme : _lightTheme,
      home: home_screen(setIsDark: setIsDark),
      routes: {
        screenAdd_transaction.routeName: (ctx) => const screenAdd_transaction(),
      },
    );
  }
}
