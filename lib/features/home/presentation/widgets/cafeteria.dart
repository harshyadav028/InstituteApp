import 'dart:convert'; // Importing necessary libraries for JSON parsing

import 'package:flutter/material.dart'; // Importing Flutter material design package
import 'package:flutter/services.dart'; // Importing services package for asset loading
import 'package:simple_animations/simple_animations.dart'; // Importing simple animations package for smooth transitions

// Widget for creating a fade animation effect
class FadeAnimation extends StatelessWidget {
  final double delay; // Delay for the animation
  final Widget child; // Widget to apply the animation on

  const FadeAnimation({super.key, required this.delay, required this.child}); // Constructor for the widget

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween() // Creating an animation sequence
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500)) // Fade In effect
      ..tween('translateY', Tween(begin: 120.0, end: 0.0),
          duration: Duration(milliseconds: 500), curve: Curves.easeOut); // Slide Up effect

    return PlayAnimationBuilder<Movie>( // Building the animation with a delay
      delay: Duration(milliseconds: (50 * delay).round()),
      duration: tween.duration, // Duration of the animation
      tween: tween, // The tween animation sequence
      child: child, // The widget to apply animation
      builder: (context, animation, child) => Opacity( // Using opacity and translation for the animation effect
        opacity: animation.get('opacity'),
        child: Transform.translate(
          offset: Offset(0, animation.get('translateY')), // Translate the widget upwards
          child: child, // The widget to be animated
        ),
      ),
    );
  }
}

// Cafeteria screen widget
class Cafeteria extends StatefulWidget {
  const Cafeteria({super.key}); // Constructor for the Cafeteria widget

  @override
  createState() => _CafeteriaState(); // State creation for the Cafeteria widget
}

class _CafeteriaState extends State<Cafeteria> {
  List<Map<String, dynamic>> cafeterias = []; // List to hold cafeteria data

  @override
  void initState() {
    super.initState();
    readJson(); // Load JSON data when the widget is initialized
  }

  // Method to load and parse the JSON data
  Future<void> readJson() async {
    try {
      // Load JSON file from assets
      String response = await rootBundle.loadString('assets/cafeteria.json');
      Map<String, dynamic> data = json.decode(response); // Parse the JSON

      // Ensure JSON structure is correct
      if (data.containsKey("cafeterias")) {
        setState(() {
          cafeterias = List<Map<String, dynamic>>.from(data["cafeterias"]);
        });
      }
    } catch (e) {
      print("Error loading JSON: $e"); // Error handling for JSON loading
    }
  }

  int _show = -1; // To manage selected cafeteria index for menu display
  String _searched = ""; // To hold the searched cafeteria name
  bool _imageLoading = true; // To manage image loading state

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context); // Get screen size for responsive UI
    List<Map<String, dynamic>> filteredCafeterias = cafeterias
        .where((cafe) =>
        cafe["name"]!.toLowerCase().contains(_searched.toLowerCase())) // Filter cafeterias based on search input
        .toList();

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Set background color
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.withOpacity(0.15), // Customize app bar
            title: const Text(
              "Cafeterias",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Set app bar title
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)), // Styling search container
                    border: Border.all(width: 0.3),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searched = value; // Update search query
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search), // Search icon
                      hintText: "Search Cafeteria", // Search placeholder text
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              if (filteredCafeterias.isNotEmpty) // Check if filtered cafeterias exist
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCafeterias.length,
                    itemBuilder: (context, index) {
                      final cafe = filteredCafeterias[index];

                      return FadeAnimation(
                        delay: 0.5 * index, // Apply animation delay based on index
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8), // Style the card container
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [
                                Colors.blueGrey.withOpacity(0.1),
                                Theme.of(context).cardColor.withOpacity(0.4),
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topCenter,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cafe["name"]!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time,
                                          color: Colors.black, size: 20), // Opening time icon
                                      const SizedBox(width: 8),
                                      Text("Time: ${cafe["openingTime"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge), // Opening time text
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.delivery_dining,
                                          color: Colors.black, size: 20), // Delivery time icon
                                      const SizedBox(width: 8),
                                      Text("Delivery: ${cafe["deliveryTime"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge), // Delivery time text
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          color: Colors.black, size: 20), // Phone icon
                                      const SizedBox(width: 8),
                                      Text(cafe["contact"]!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge), // Contact number text
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          color: Colors.black, size: 20), // Location icon
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(cafe["location"]!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge), // Location text
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _show = index; // Set the index to show menu
                                          _imageLoading =
                                          true; // Reset loading state
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(8)),
                                      ),
                                      child: const Text(
                                        "View Menu",
                                        style: TextStyle(color: Colors.white), // Button text
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "No Cafeteria Found",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Message when no cafeteria found
                  ),
                ),
            ],
          ),
        ),
        if (_show != -1) // Check if a cafeteria's menu is to be shown
          Container(
            color: Colors.black.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: cafeterias[_show]["menuImages"].length, // Show the menu images
                    itemBuilder: (context, imgIndex) {
                      return Center(
                        child: Image.network(
                          cafeterias[_show]["menuImages"][imgIndex], // Show image from the menu
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400] // Close button style
                    ),
                    onPressed: () {
                      setState(() {
                        _show = -1; // Close the menu view
                      });
                    },
                    child: Container(
                      width: screenSize.width/4, // Set close button width
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.close,size: 25,color: Colors.black,), // Close icon
                          SizedBox(width: 6,),
                          const Text("Close", style: TextStyle(fontSize: 18,color: Colors.black),), // Close text
                        ],
                      ),
                    )
                ),
              ],
            ),
          )
      ],
    );
  }
}
