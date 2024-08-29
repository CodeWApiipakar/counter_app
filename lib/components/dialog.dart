import 'dart:convert';

import 'package:counter/components/controls.dart';
import 'package:flutter/material.dart';
import "dart:math";

Future<void> dialogBuilder(
    BuildContext context,
    String itemTitle,
    String itemId,
    dynamic itemValue,
    Function handleChanges,
    colorValue,
    Function updateState) {
  Controls controls = Controls();

  TextEditingController txtItemName = TextEditingController();
  TextEditingController txtItemValue = TextEditingController();
  itemTitle == "Create new item"
      ? txtItemValue.text = "0"
      : txtItemValue.text = itemValue.toString();
  txtItemName.text = itemId;

  // txtItemValue.selection = TextSelection(baseOffset: 10, extentOffset: 15);
  List<int> sColors = [
    0xFFE10000,
    0xFFC6A700,
    0xFF0E007B,
    0xFF6B006C,
    0xFF006C02,
    0xFFA55A00,
    0xFF5C5C5C,
  ];

  // Randomly select an initial color index
  int selectedIndex;
  int CurrentColor = sColors.indexOf(colorValue);

  itemTitle == "Create new item"
      ? selectedIndex = Random().nextInt(sColors.length)
      : selectedIndex = CurrentColor;
  var selectedColor;
  selectedColor = sColors[selectedIndex];

  // print("current color : $CurrentColor");
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Dialog(
            child: Container(
              width: double.infinity,
              height: 370,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemTitle,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofocus: itemTitle == "Create new item" && true,
                    controller: txtItemName,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      fillColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.grey),
                      focusColor: Colors.grey,
                      hintText: "Item Name",
                      labelText: "Item Name",
                      suffix: Icon(Icons.edit),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    autofocus: itemTitle != "Create new item" && true,
                    controller: txtItemValue,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      fillColor: Colors.grey,
                      labelStyle: TextStyle(color: Colors.grey),
                      focusColor: Colors.grey,
                      hintText: "",
                      labelText: "Item Value",
                      suffix: Icon(Icons.edit),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 30, // Set a fixed height for the ListView
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sColors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              selectedColor =
                                  sColors[index]; // Set the selected index
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              border: selectedIndex == index
                                  ? Border.all(width: 2, color: Colors.grey)
                                  : null,
                              color: Color(sColors[index]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            padding: EdgeInsets.all(20),
                            color: Colors.deepPurple,
                            onPressed: () async {
                              if (itemTitle == "Create new item") {
                                handleChanges(txtItemName.text,
                                    txtItemValue.text, selectedColor);
                                Navigator.of(context).pop();
                              } else {
                                // handleChanges(
                                //   itemId,
                                //   txtItemName.text,
                                //   txtItemValue.text,
                                //   selectedColor,
                                // );
                                controls.updateItem(
                                    itemId,
                                    txtItemName.text,
                                    txtItemValue.text,
                                    selectedColor,
                                    updateState);
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text(
                              "Save",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
