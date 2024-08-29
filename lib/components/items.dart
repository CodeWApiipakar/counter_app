import 'package:counter/components/changeValueDialog.dart';
import 'package:counter/components/controls.dart';
import 'package:counter/components/dialog.dart';
import 'package:flutter/material.dart';

Widget itemsList(context, updateState, getContainerSize) {
  Controls control = Controls();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  var screenSize = MediaQuery.of(context).size;
  // print("from items list-------------------------------");
  // print(items);
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
    decoration: BoxDecoration(),
    width: screenSize.width,
    height: screenSize.height,
    child: ListView.builder(
      itemCount: Controls.items.length,
      itemBuilder: (context, index) {
        String key = Controls.items.keys.elementAt(index);
        int colorValue = Controls.items[key]![1];
        String itemValue = Controls.items[key]![0];
        int numberValue = int.parse(itemValue);
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Color(colorValue).withOpacity(0.9),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Column(
            children: [
              Container(
                color: Color(colorValue).withOpacity(0.75),
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      key,
                      style: TextStyle(
                          fontSize: 20,
                          color: isDarkMode ? Colors.white : Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          dialogBuilder(
                              context, "Modify this item", key, itemValue,
                              (newItemId, newValue, color) {
                            control.handleChanges(
                                newItemId, newValue, color, updateState);
                          }, colorValue, updateState);
                        },
                        icon: Icon(Icons.edit,
                            color: isDarkMode ? Colors.white : Colors.white))
                  ],
                ),
              ),
              Container(
                height: getContainerSize(Controls.items.length),
                // padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: double.infinity,
                      child: IconButton(
                        onPressed: () async {
                          updateState(() {
                            numberValue--; // Increment the number value
                            Controls.items[key]![0] =
                                numberValue.toString(); // Update the map
                            control.saveHistory(
                                key,
                                itemValue,
                                itemValue.toString(),
                                colorValue,
                                "decrement",
                                updateState);
                          });

                          // Save the entire map to SharedPreferences
                          await control.saveToSharedPreferences(Controls.items);
                        },
                        icon: Icon(Icons.remove,
                            color: isDarkMode ? Colors.white : Colors.white),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          changeValueDialog(context, "Edit $key", key,
                              itemValue, updateState, colorValue);
                        },
                        child: Text(
                          itemValue,
                          style: TextStyle(
                              fontSize: 65,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      height: double.infinity,
                      child: IconButton(
                        onPressed: () async {
                          updateState(() {
                            numberValue++; // Increment the number value
                            Controls.items[key]![0] = numberValue.toString();
                            control.saveHistory(
                                key,
                                itemValue,
                                itemValue.toString(),
                                colorValue,
                                "increment",
                                updateState); // Update the map
                          });

                          // Save the entire map to SharedPreferences
                          await control.saveToSharedPreferences(Controls.items);
                        },
                        icon: Icon(Icons.add,
                            color: isDarkMode ? Colors.white : Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
