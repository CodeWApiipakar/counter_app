import 'package:flutter/material.dart';
import 'package:easy_url_launcher/easy_url_launcher.dart';

class Aboutme extends StatelessWidget {
  const Aboutme({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("About Me"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: IconButton(
              tooltip: "Contact Me",
              onPressed: () async {
                await EasyLauncher.call(number: "0907789485");
              },
              icon: Icon(Icons.phone),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.2),
                      width: 5)),
              margin: EdgeInsets.only(top: 40),
              child: ClipOval(
                child: Image.asset(
                  'Assets/Photo.jpeg', // Replace with your image URL
                  width: 150, // Set the width of the circle
                  height: 150, // Set the height of the circle
                  fit: BoxFit.cover, // Ensures the image covers the entire area
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Apiipakar Mohamoud Abdi.",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Software Developer",
              style: TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
