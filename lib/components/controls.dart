import 'dart:convert';

import 'package:counter/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controls {
  Map<String, dynamic> items = {};
  dynamic itemid = "";
  int? itemValue;
  String itemTitle = "Create new item";
  int currentColor = 0;
  void handleChanges(String newItemId, String itemValue, var itemColor,
      Function updateState) async {
    // Retrieve SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Perform the async operation outside of setState
    Map<String, List<dynamic>> existingItems =
        await getItemsFromSharedPreferences();

    // Check if the newItemId is not empty and doesn't already exist in the map
    if (newItemId.isNotEmpty && !existingItems.containsKey(newItemId)) {
      // Add the new item to the map
      existingItems[newItemId] = [itemValue, itemColor];

      // Convert updated items map to JSON string and save it to SharedPreferences
      String jsonItems = jsonEncode(existingItems);
      await prefs.setString("items", jsonItems);

      // Optionally update itemid using the callback
      updateState(() {
        itemid = newItemId;
      });

      getOldItems(updateState);
    }
  }

//update item
  void updateItem(oldTitle, title, key, value, color) {
    print(
        "-------------------------------------- console --------------------------------");
    print("Title : $title Key:$key value:$value color:$color");
  }

  //get old items from shared Preferences.
  void getOldItems(Function updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stringdata = prefs.getString('items');
    if (stringdata != null) {
      Map<String, dynamic> jsonObject = await jsonDecode(stringdata.toString());
      updateState(() {
        items = jsonObject;
      });
    }
    // print(items);
  }

  // Function to get items from SharedPreferences
  Future<Map<String, List<dynamic>>> getItemsFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('items');
    if (jsonString != null) {
      Map<String, dynamic> map = jsonDecode(jsonString);
      return map.map((key, value) => MapEntry(key, List<dynamic>.from(value)));
    }
    return {};
  }

  void removeOldItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("items");
  }
}
