import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({super.key, required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 500)) // Fade In
      ..tween('translateY', Tween(begin: 120.0, end: 0.0),
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);

    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (50 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, animation, child) => Opacity(
        opacity: animation.get('opacity'),
        child: Transform.translate(
          offset: Offset(0, animation.get('translateY')),
          child: child,
        ),
      ),
    );
  }
}

class Cafeteria extends StatefulWidget {
  const Cafeteria({super.key});

  @override
  createState() => _CafeteriaState();
}

class _CafeteriaState extends State<Cafeteria> {
  List<Map<String, dynamic>> cafeterias = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    try {
      // Load JSON file from assets
      String response = await rootBundle.loadString('assets/cafeteria.json');
      Map<String, dynamic> data = json.decode(response);

      // Ensure JSON structure is correct
      if (data.containsKey("cafeterias")) {
        setState(() {
          cafeterias = List<Map<String, dynamic>>.from(data["cafeterias"]);
        });
      }
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }


  int _show = -1;
  String _searched = "";
  bool _imageLoading = true;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.sizeOf(context);
    List<Map<String, dynamic>> filteredCafeterias = cafeterias
        .where((cafe) =>
        cafe["name"]!.toLowerCase().contains(_searched.toLowerCase()))
        .toList();

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.withOpacity(0.15),
            title: const Text(
              "Cafeterias",
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(width: 0.3),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searched = value;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Search Cafeteria",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              if (filteredCafeterias.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCafeterias.length,
                    itemBuilder: (context, index) {
                      final cafe = filteredCafeterias[index];

                      return FadeAnimation(
                        delay: 0.5 * index,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
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
                                          color: Colors.black, size: 20),
                                      const SizedBox(width: 8),
                                      Text("Time: ${cafe["openingTime"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.delivery_dining,
                                          color: Colors.black, size: 20),
                                      const SizedBox(width: 8),
                                      Text("Delivery: ${cafe["deliveryTime"]}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone,
                                          color: Colors.black, size: 20),
                                      const SizedBox(width: 8),
                                      Text(cafe["contact"]!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          color: Colors.black, size: 20),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(cafe["location"]!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _show = index;
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
                                        style: TextStyle(color: Colors.white),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
        if (_show != -1)
          Container(
            color: Colors.black.withOpacity(0.8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: cafeterias[_show]["menuImages"].length,
                    itemBuilder: (context, imgIndex) {
                      return Center(
                        child: Image.network(
                          cafeterias[_show]["menuImages"][imgIndex],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400]
                    ),
                    onPressed: () {
                      setState(() {
                        _show = -1;
                      });
                    },
                    child: Container(
                      width: screenSize.width/4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.close,size: 25,color: Colors.black,),
                          SizedBox(width: 6,),
                          const Text("Close", style: TextStyle(fontSize: 18,color: Colors.black),),
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
