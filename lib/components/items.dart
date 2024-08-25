import 'package:counter/components/dialog.dart';
import 'package:flutter/material.dart';

Widget itemsList(screenSize, items, getContainerSize) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
    decoration: BoxDecoration(),
    width: screenSize.width,
    height: screenSize.height,
    child: ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        String key = items.keys.elementAt(index);
        int colorValue = items[key]![1];
        String itemValue = items[key]![0];

        print(items.length);
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
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          // dialogBuilder(context, key, key, itemValue, handleChanges)
                          print(items.keys.elementAt(index));
                        },
                        icon: const Icon(
                          Icons.edit,
                        ))
                  ],
                ),
              ),
              Container(
                height: getContainerSize,
                child: Center(
                    child: Text(
                  itemValue,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                )),
              )
            ],
          ),
        );
      },
    ),
  );
}
