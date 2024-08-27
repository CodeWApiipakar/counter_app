import 'package:counter/components/controls.dart';
import 'package:counter/components/dialog.dart';
import 'package:flutter/material.dart';

Widget itemsList(screenSize, items, getContainerSize) {
  Controls control = Controls();

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
                          dialogBuilder(context, "Modify this item", key,
                              itemValue, control.updateItem, colorValue);
                        },
                        icon: const Icon(
                          Icons.edit,
                        ))
                  ],
                ),
              ),
              Container(
                height: getContainerSize,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    ),
                    Center(
                      child: Text(
                        itemValue,
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
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
