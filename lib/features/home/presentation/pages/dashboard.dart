import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final bool isGuest;
  const Dashboard({super.key, required this.isGuest});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("This page is not yet created",
          style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
