import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:math';

import 'package:flutter_responsive_app/screens/responsive_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //Media Query variables
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Responsive App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Screen Height: ${size.height}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Screen Width: ${size.width}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Screen Orientation: ${orientation}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Screen Top Padding: ${padding.top}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Screen Bottom Padding: ${padding.bottom}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              //Responsive Container
              Center(
                child: Container(
                  width: size.width * 0.8,
                  height: orientation == Orientation.portrait ? 100 : 50,
                  color: Colors.pink[100],

                  child: Center(child: Text("Responsive Layout")),
                ),
              ),

              SizedBox(height: 10, width: 10),

              //Orientation based Layout
              orientation == Orientation.portrait
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildBoxes(),
                      ),
                    )
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _buildBoxes(),
                      ),
                    ),

              SizedBox(height: 10, width: 10),

              //Platform
              if (Platform.isAndroid)
                Text("This is Android")
              else if (Platform.isIOS)
                Text("This is iOS"),

              SizedBox(height: 10, width: 10),

              // Responsive App Main Design
              Center(
                child: ElevatedButton(
                  child: Text("Check Responsive Design"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white, // Text color
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResponsiveScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBoxes() {
    return [
      Container(
        color: Colors.green,
        child: Center(child: Text("Box 1")),
      ),
      SizedBox(height: 10, width: 10),
      Container(
        color: Colors.amberAccent,
        child: Center(child: Text("Box 2")),
      ),
    ];
  }
}
