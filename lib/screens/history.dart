import 'package:counter/components/controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // print(Controls.history);
    return Scaffold(
      appBar: AppBar(
        title: Text("History List"),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 20), child: Icon(Icons.history))
        ],
      ),
      body: Controls.history.isEmpty
          ? Center(
              child: Text("Please Make some items entry"),
            )
          : Container(
              margin: EdgeInsets.only(top: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(0),
              child: ListView.builder(
                itemCount: Controls.history.length,
                itemBuilder: (context, index) {
                  var item = Controls.history[index];
                  var itemTitle = item[0];
                  var itemFromValue = item[1];
                  var itemToValue = item[2];
                  var itemColor = item[3];

                  print(itemColor);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      tileColor: Color(itemColor),
                      title: Text(
                        // item[0],
                        itemTitle,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      subtitle: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "From:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              itemFromValue.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "To:",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              itemToValue.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
