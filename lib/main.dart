import 'package:counter/components/dialog.dart';
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
  Map<dynamic, List<dynamic>> items = {};
  dynamic itemid = "";
  int? itemValue;
  String itemTitle = "Create new item";
  var isSelected = false;

  void handleSelected() {
    setState(() {
      isSelected = !isSelected;
    });
  }

  //handle add item
  void addNewItem() {
    setState(() {
      var itemIdIncrement = items.length + 1;
      itemid = "Item $itemIdIncrement";
      itemValue = 0;
      dialogBuilder(
          context, itemTitle, itemid, itemValue, isSelected, handleSelected);
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(addNewItem),
      body: Center(),
    );
  }
}
