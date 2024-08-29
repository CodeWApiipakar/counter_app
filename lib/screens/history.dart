import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History List"),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 20), child: Icon(Icons.history))
        ],
      ),
      body: Center(
        child: Text("History list"),
      ),
    );
  }
}
