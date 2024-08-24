import 'package:counter/components/dialog.dart';
import 'package:counter/components/myAppBar.dart';
import 'package:counter/screens/splashScreenOne.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  Map<String, dynamic> items = {};
  dynamic itemid = "";
  int? itemValue;
  String itemTitle = "Create new item";

// change value items and save them to shared prefs
  void handleChanges(String newItemId, String itemValue, var itemColor) async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Perform the async operation outside of setState
    Map<String, List<dynamic>> updatedItems =
        await getItemsFromSharedPreferences();

    // Update itemid and items map
    setState(() {
      if (newItemId.isNotEmpty) {
        // Check if the newItemId exists
        if (updatedItems.containsKey(newItemId)) {
          // Update existing entry
          updatedItems[newItemId] = [itemValue, itemColor];
        } else {
          // Add new entry
          updatedItems[newItemId] = [itemValue, itemColor];
        }

        // Optionally update itemid if needed
        itemid = newItemId;
      }

      // Convert updated items map to JSON string and save it to SharedPreferences
      String jsonItems = jsonEncode(updatedItems);
      prefs.setString("items", jsonItems);
    });
  }

// Function to get items from SharedPreferences
  Future<Map<String, List<dynamic>>> getItemsFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('items');
    if (jsonString != null) {
      Map<String, List<dynamic>> map = jsonDecode(jsonString);
      return map.map((key, value) => MapEntry(key, List<dynamic>.from(value)));
    }
    return {};
  }

  //handle add item
  void addNewItem() {
    setState(() {
      var itemIdIncrement = items.length + 1;
      itemid = "Item $itemIdIncrement";
      itemValue = 0;
      dialogBuilder(context, itemTitle, itemid, itemValue, handleChanges);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // removeOldItems();
    getOldItems();
  }

//get old items from shared Preferences.
  void getOldItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stringdata = prefs.getString('items');
    if (stringdata != null) {
      Map<String, dynamic> jsonObject = await jsonDecode(stringdata.toString());
      setState(() {
        items = jsonObject;
      });
      print(items);
    }
  }

  void removeOldItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("items");
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
