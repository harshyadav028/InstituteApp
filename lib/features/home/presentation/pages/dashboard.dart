import 'package:flutter/material.dart';
import 'package:uhl_link/config/routes/routes_consts.dart';
import 'package:uhl_link/features/home/presentation/widgets/dashboard_cart.dart';

class Dashboard extends StatefulWidget {
  final bool isGuest;
  const Dashboard({super.key, required this.isGuest});
  
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String , dynamic>> items = [
    {
      "title": 'Lost/Found',
      "icon":  Icons.card_travel,
      'path': UhlLinkRoutesNames.lostFoundPage,    
    },
    {
      "title": 'Buy/Sell',
      "icon":   Icons.shopping_cart_outlined,  
      "path": UhlLinkRoutesNames.test,   
    },
    {
      "title": 'Maps',
      "icon":  Icons.map_outlined,    
      "path": UhlLinkRoutesNames.campusMapPage, 
    },
    {
      "title": 'Calendar',
      "icon": Icons.calendar_today_outlined,   
      "path":  UhlLinkRoutesNames.test,
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
                     child: Column(
                      mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Explore",
                                style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(fontSize: 25),
                              ),    
                      SizedBox(
                        height:  MediaQuery.of(context).size.height * .02,
                      )   ,                  
                      SizedBox(
                      width: MediaQuery.of(context).size.width-40,
                      height: MediaQuery.of(context).size.height * .30,
                        child: GridView.count(
                            crossAxisCount: 3,
                             physics: const NeverScrollableScrollPhysics(),
                            children: [
                              for (int i = 0 ; i < items.length;i++)
                              DashboardCard(
                                  title: items[i]['title'],
                                  icon: items[i]['icon'],
                                  path : items[i]['path'],
                              ),],),
                      
                                     ),
                                     
                                   ],
                                   ),
                   );   
  }
}

