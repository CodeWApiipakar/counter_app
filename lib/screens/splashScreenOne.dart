import 'package:counter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreenone extends StatefulWidget {
  const Splashscreenone({super.key});

  @override
  State<Splashscreenone> createState() => _SplashscreenoneState();
}

class _SplashscreenoneState extends State<Splashscreenone> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("Assets/image1.png"),
          const SizedBox(
            height: 10,
          ),
          const Text("Count every think you need",
              style: TextStyle(fontSize: 25)),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: isDarkMode
                    ? Colors.white
                    : Colors.black, // Button background color
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 10), // Padding inside the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Button shape
                ),
              ),
              onPressed: () async {
                final SharedPreferences splashPrefs =
                    await SharedPreferences.getInstance();
                splashPrefs.setBool("splashSeen", true);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text("Next",
                  style: TextStyle(
                    fontSize: 20,
                    color: isDarkMode ? Colors.black : Colors.white,
                  )))
        ],
      ),
    );
  }
}
