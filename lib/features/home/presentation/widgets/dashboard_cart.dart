import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String path;

  const DashboardCard(
      {super.key, required this.title, required this.icon, required this.path});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).pushNamed(widget.path);
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            color: Colors.blue,
            elevation: 4,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.icon, size: 25, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}