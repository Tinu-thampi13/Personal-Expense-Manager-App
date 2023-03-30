// Import all the necessary pakages for the HomeScreen page
import 'package:flutter/material.dart';
import 'package:iota/db/category/category_db.dart';
import 'package:iota/models/category/category_model.dart';
import 'package:iota/screens/category/category_screen.dart';
import 'package:iota/screens/category/widgets/category_add_popup.dart';
import 'package:iota/screens/home/widgets/bottom_nav.dart';
import 'package:iota/screens/transaction/transaction_screen.dart';
import 'package:iota/screens/transaction/widgets/add_transactions.dart';

// ignore: camel_case_types
class home_screen extends StatefulWidget {
  late Function setIsDark;
  home_screen({super.key, required this.setIsDark});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  final _pages = const [
    transaction_screen(),
    category_screen(),
  ];

  bool _iconBool = false;

  IconData _lightMode = Icons.wb_sunny;

  IconData _nightMode = Icons.nights_stay;

  // theme: _iconBool ? _darkTheme : _lightTheme,
  @override
  Widget build(BuildContext context) {
    // UI for Homescreen page
    return Scaffold(
      appBar: AppBar(
        title: const Text('IOTA'),
        actions: [
          IconButton(
            onPressed: () {
              widget.setIsDark();

              setState(() {
                _iconBool = !_iconBool;
              });
            },
            icon: Icon(_iconBool ? _nightMode : _lightMode),
          )
        ],
      ),
      bottomNavigationBar: const bottom_nav(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: home_screen.selectedIndexNotifier,
            builder: (BuildContext context, int updatedIndex, _) {
              return _pages[updatedIndex];
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (home_screen.selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(screenAdd_transaction.routeName);
          } else {
            showCategoryAddPopup(context);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
