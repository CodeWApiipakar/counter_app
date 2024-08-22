import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context, String itemTitle,
    String itemId, dynamic itemValue, isSelected, actionOne) {
  TextEditingController txtItemName = TextEditingController();
  TextEditingController txtItemValue = TextEditingController();
  txtItemValue.text = itemValue.toString();
  txtItemName.text = itemId;

  List<int> sColors = [
    0xFFE10000,
    0xFFC6A700,
    0xFF0E007B,
    0xFF6B006C,
    0xFF006C02,
    0xFFA55A00,
    0xFF5C5C5C,
  ];

  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          width: double.infinity,
          height: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
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
                controller: txtItemValue,
                keyboardType: TextInputType.number,
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  fillColor: Colors.grey,
                  labelStyle: TextStyle(color: Colors.grey),
                  focusColor: Colors.grey,
                  hintText: "0",
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
                        actionOne();
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: isSelected == true
                              ? Border.all(width: 2, color: Colors.grey)
                              : null,
                          color: Color(sColors[index]),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
