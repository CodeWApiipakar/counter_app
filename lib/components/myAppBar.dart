import 'package:counter/components/controls.dart';
import 'package:counter/screens/history.dart';
import 'package:counter/screens/owner.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar myAppBar(context, addFuntion, updateState) {
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => History()),
              );
            },
            icon: Icon(Icons.history),
          ),
          PopupMenuButton<String>(
            offset: Offset(0, 40),
            onSelected: (value) {
              // Handle the selected menu item here
              print('Selected: $value');
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  onTap: () {
                    control.releaseValues(updateState);
                  },
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
                      Text("Release Values"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    control.removeOldItems(updateState);
                  },
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            // print(Controls.items);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      Text("Delete All"),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Aboutme()),
                    );
                  },
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.info_outline,
                            color: Colors.green,
                          )),
                      Text("Owner"),
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
