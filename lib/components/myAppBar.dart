import 'package:counter/components/controls.dart';
import 'package:flutter/material.dart';

AppBar myAppBar(addFuntion) {
  Controls control = Controls();
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text("Counter App"),
    actions: [
      Row(
        children: [
          IconButton(
            onPressed: addFuntion,
            icon: Icon(Icons.add_circle),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.history),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle the selected menu item here
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                      Text("Release Values"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Option 1',
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      Text("Delete All"),
                    ],
                  ),
                ),
              ];
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    ],
  );
}
