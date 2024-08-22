import 'package:flutter/material.dart';

AppBar buildAppBar(addFuntion) {
  return AppBar(
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    ],
  );
}
