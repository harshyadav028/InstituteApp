import 'package:flutter/material.dart';
import 'package:uhl_link/config/routes/routes_consts.dart';
import 'package:uhl_link/features/home/presentation/widgets/dashboard_card.dart';

class Dashboard extends StatefulWidget {
  final bool isGuest;
  const Dashboard({super.key, required this.isGuest});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> items = [
    {
      "title": 'Lost/Found',
      "icon": Icons.card_travel,
      'path': UhlLinkRoutesNames.lostFoundPage,
    },
    {
      "title": 'Buy/Sell',
      "icon": Icons.shopping_cart_outlined,
      "path": UhlLinkRoutesNames.test,
    },
    {
      "title": 'Maps',
      "icon": Icons.map_outlined,
      "path": UhlLinkRoutesNames.campusMapPage,
    },
    {
      "title": 'Calendar',
      "icon": Icons.calendar_today_outlined,
      "path": UhlLinkRoutesNames.academicCalenderPage,
    },
    {
      "title": 'Events',
      "icon": Icons.menu,
      "path": UhlLinkRoutesNames.test,
    },
    {
      "title": 'Mess Menu',
      "icon": Icons.restaurant,
      "path": UhlLinkRoutesNames.messMenuPage,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      primary: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Explore",
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 23),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
            child: GridView.count(
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: [
                for (int i = 0; i < items.length; i++)
                  DashboardCard(
                    title: items[i]['title'],
                    icon: items[i]['icon'],
                    path: items[i]['path'],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
