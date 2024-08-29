import 'dart:convert';

import 'package:counter/components/controls.dart';
import 'package:counter/components/dialog.dart';
import 'package:counter/components/items.dart';
import 'package:counter/components/myAppBar.dart';
import 'package:counter/screens/splashScreenOne.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure initialization before runApp
  final prefs = await SharedPreferences.getInstance();
  final isSplashSeen = prefs.getBool('splashSeen') ?? false;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system,
    home: isSplashSeen ? Home() : Splashscreenone(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Controls controls = Controls();
  Map<String, dynamic> lastItemsUpdated = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controls.removeOldItems();
    controls.getOldItems(setState);
  }

//container size handler.
  double getContainerSize(itemsLength) {
    double size;
    if (itemsLength == 2) {
      size = 200;
    } else if (itemsLength == 1) {
      size = 250;
    } else if (itemsLength == 3) {
      size = 160;
    } else if (itemsLength == 4) {
      size = 110;
    } else {
      size = 80;
    }
    return size;
  }

// Handle add item
  void addNewItem() {
    setState(() {
      var itemIdIncrement = Controls.items.length + 1;
      controls.itemid = "Item $itemIdIncrement";
      controls.itemValue = 0;
      dialogBuilder(
          context, controls.itemTitle, controls.itemid, controls.itemValue,
          (newItemId, newValue, color) {
        controls.handleChanges(newItemId, newValue, color, setState);
      }, controls.currentColor, setState);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: myAppBar(context, addNewItem, setState),
        body: Controls.items.isEmpty
            ? const Center(
                child: Text("Click + icon to add new item"),
              )
            : itemsList(context, setState, getContainerSize));
  }
}
