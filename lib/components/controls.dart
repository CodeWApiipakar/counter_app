import 'dart:convert';
import 'package:counter/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controls {
  static Map<String, dynamic> items = {};
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
        getOldItems(updateState);
      });
    }
  }

//============================================ update items
  void updateItem(String oldTitle, String title, String itemvalue, var color,
      Function updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<dynamic>> itemsList =
        await getItemsFromSharedPreferences();

    // Create a new map to store updated items
    Map<String, List<dynamic>> updatedItems = {};

    itemsList.forEach((key, value) {
      if (key == oldTitle) {
        // Update the list for the old key
        List<dynamic> updatedList = [itemvalue, color];
        updatedItems[title] = updatedList;
        // Fetch and update the state again
        getOldItems(updateState);
      } else {
        updatedItems[key] = value;
      }
    });

    // Save the updated map back to shared preferences
    String jsonItems = jsonEncode(updatedItems);
    await prefs.setString("items", jsonItems);

    updateState(() {
      items = updatedItems;
    });
    getOldItems(updateState);
  }

//============================================ Release values items
  void releaseValues(Function updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<dynamic>> itemsList =
        await getItemsFromSharedPreferences();

    // Create a new map to store updated items
    Map<String, List<dynamic>> updatedItems = {};

    itemsList.forEach((key, value) {
      value[0] = "0";
      updatedItems[key] = value;
    });

    // Save the updated map back to shared preferences
    String jsonItems = jsonEncode(updatedItems);
    await prefs.setString("items", jsonItems);

    updateState(() {
      items = updatedItems;
    });
    getOldItems(updateState);
  }

  //============================================ update only value items
  void updateOnlyValue(
      String title, int oldValue, int newValue, Function updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, List<dynamic>> itemsList =
        await getItemsFromSharedPreferences();

    // Create a new map to store updated items
    Map<String, List<dynamic>> updatedItems = {};
    int itemValue = 0;

    itemsList.forEach((key, value) {
      if (key == title) {
        // Update the list for the old key
        if (newValue == 0) {
          itemValue = newValue;
        } else {
          itemValue = oldValue + newValue;
        }
        // List<dynamic> updatedList = [itemValue];
        value[0] = itemValue.toString();
        updatedItems[title] = value;
        // print(updatedItems);
        // Fetch and update the state again
        // getOldItems(updateState);
      } else {
        updatedItems[key] = value;
      }
    });

    // Save the updated map back to shared preferences
    String jsonItems = jsonEncode(updatedItems);
    await prefs.setString("items", jsonItems);

    updateState(() {
      items = updatedItems;
    });
    getOldItems(updateState);
  }

  //================================== get old items from shared Preferences.
  void getOldItems(Function updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var stringdata = prefs.getString('items');
    if (stringdata != null) {
      Map<String, dynamic> jsonObject = await jsonDecode(stringdata);
      updateState(() {
        items = jsonObject;
      });
    }
    print("Loaded items from SharedPreferences: ${items}");
  }

  //==================================Function to get items from SharedPreferences
  Future<Map<String, List<dynamic>>> getItemsFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('items');
    if (jsonString != null) {
      Map<String, dynamic> map = jsonDecode(jsonString);
      return map.map((key, value) => MapEntry(key, List<dynamic>.from(value)));
    }
    return {};
  }

// Function to save the updated map to SharedPreferences
  Future<void> saveToSharedPreferences(Map<String, dynamic> items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(items); // Convert map to JSON string
    prefs.setString('items', jsonString); // Save the JSON string
    print(items);
  }

  void removeOldItems(updateState) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("items");
    updateState(() {
      items = {};
    });
  }
}
