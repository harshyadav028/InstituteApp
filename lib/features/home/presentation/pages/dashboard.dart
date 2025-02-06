import 'package:flutter/material.dart';

<<<<
<<
<

HEAD
import
'
package:carousel_slider/carousel_slider.dart
';
==
==
==
=
import 'package:uhl_link/config/routes/routes_consts.dart';
import 'package:uhl_link/features/home/presentation/widgets/dashboard_cart.dart';

>>
>
>
>
>
>
main

class Dashboard extends StatefulWidget {
  final bool isGuest;

  const Dashboard({super.key, required this.isGuest});

  @override
  State<Dashboard> createState() => _DashboardState();
}

int _currentPage = 0;

final List<String> imgList = [
  'https://s3-alpha-sig.figma.com/img/0e7c/ea71/9879eb5c1016e819565ab227c4fe4974?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=IwHn9wkuD7kSsGD~RH23JRRcXULbWbIqegN~flsVWYPC-ND8-qYMwX~v9mDfX35nXHpllmamnUxO0nQQ-XIUdhjTrsP7~JY~tZdGdvoMHEKvmrZPWeozEuQHVlU0wQTEpGdxcOZ3R9gvRILD2dvT8e2hggj5X9OQN7GE1IzV9GwE91KiY4yhcEx9LhZt5tA-yJqSh3LY4cypB40qcy8UeYMxhzcV5vczdGZnoO1h43NWgXEsrbeTGV~bnSdNflNymR7QpJykVtOJCXxnJ3u61N9rvHcXbaI4141qJeyafPT1~Cx0pqnzcFIgZdvpgA8BU6NQobOhmFKQUHKQEDS8KA__',
  'https://s3-alpha-sig.figma.com/img/0e7c/ea71/9879eb5c1016e819565ab227c4fe4974?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=IwHn9wkuD7kSsGD~RH23JRRcXULbWbIqegN~flsVWYPC-ND8-qYMwX~v9mDfX35nXHpllmamnUxO0nQQ-XIUdhjTrsP7~JY~tZdGdvoMHEKvmrZPWeozEuQHVlU0wQTEpGdxcOZ3R9gvRILD2dvT8e2hggj5X9OQN7GE1IzV9GwE91KiY4yhcEx9LhZt5tA-yJqSh3LY4cypB40qcy8UeYMxhzcV5vczdGZnoO1h43NWgXEsrbeTGV~bnSdNflNymR7QpJykVtOJCXxnJ3u61N9rvHcXbaI4141qJeyafPT1~Cx0pqnzcFIgZdvpgA8BU6NQobOhmFKQUHKQEDS8KA__',
  'https://s3-alpha-sig.figma.com/img/0e7c/ea71/9879eb5c1016e819565ab227c4fe4974?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=IwHn9wkuD7kSsGD~RH23JRRcXULbWbIqegN~flsVWYPC-ND8-qYMwX~v9mDfX35nXHpllmamnUxO0nQQ-XIUdhjTrsP7~JY~tZdGdvoMHEKvmrZPWeozEuQHVlU0wQTEpGdxcOZ3R9gvRILD2dvT8e2hggj5X9OQN7GE1IzV9GwE91KiY4yhcEx9LhZt5tA-yJqSh3LY4cypB40qcy8UeYMxhzcV5vczdGZnoO1h43NWgXEsrbeTGV~bnSdNflNymR7QpJykVtOJCXxnJ3u61N9rvHcXbaI4141qJeyafPT1~Cx0pqnzcFIgZdvpgA8BU6NQobOhmFKQUHKQEDS8KA__',
  'https://s3-alpha-sig.figma.com/img/0e7c/ea71/9879eb5c1016e819565ab227c4fe4974?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=IwHn9wkuD7kSsGD~RH23JRRcXULbWbIqegN~flsVWYPC-ND8-qYMwX~v9mDfX35nXHpllmamnUxO0nQQ-XIUdhjTrsP7~JY~tZdGdvoMHEKvmrZPWeozEuQHVlU0wQTEpGdxcOZ3R9gvRILD2dvT8e2hggj5X9OQN7GE1IzV9GwE91KiY4yhcEx9LhZt5tA-yJqSh3LY4cypB40qcy8UeYMxhzcV5vczdGZnoO1h43NWgXEsrbeTGV~bnSdNflNymR7QpJykVtOJCXxnJ3u61N9rvHcXbaI4141qJeyafPT1~Cx0pqnzcFIgZdvpgA8BU6NQobOhmFKQUHKQEDS8KA__',
  'https://s3-alpha-sig.figma.com/img/0e7c/ea71/9879eb5c1016e819565ab227c4fe4974?Expires=1738540800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=IwHn9wkuD7kSsGD~RH23JRRcXULbWbIqegN~flsVWYPC-ND8-qYMwX~v9mDfX35nXHpllmamnUxO0nQQ-XIUdhjTrsP7~JY~tZdGdvoMHEKvmrZPWeozEuQHVlU0wQTEpGdxcOZ3R9gvRILD2dvT8e2hggj5X9OQN7GE1IzV9GwE91KiY4yhcEx9LhZt5tA-yJqSh3LY4cypB40qcy8UeYMxhzcV5vczdGZnoO1h43NWgXEsrbeTGV~bnSdNflNymR7QpJykVtOJCXxnJ3u61N9rvHcXbaI4141qJeyafPT1~Cx0pqnzcFIgZdvpgA8BU6NQobOhmFKQUHKQEDS8KA__'
];

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
      "path": UhlLinkRoutesNames.test,
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
    final screenSize = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          CarouselSlider(items: imgList.map((e) =>
              Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.2),
                          width: 1.5,
                        ),
                        image: DecorationImage(image: NetworkImage(e),
                            fit: BoxFit.cover)
                    ),
                  ),
                ),
              )).toList(), options: CarouselOptions(
              height: 230,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 5),
              enlargeCenterPage: true,
// enlargeFactor: 0.2,
              onPageChanged: (value, _) {
                setState(() {
                  _currentPage = value;
                });
              }

          )),

          buildCarouselIndicator(),
          Text(
            "Explore",
            style: Theme
                .of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontSize: 25),
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * .02,
          ),
          SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width - 40,
            height: MediaQuery
                .of(context)
                .size
                .height * .30,
            child: GridView.count(
              crossAxisCount: 3,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (int i = 0; i < items.length; i++)
                  DashboardCard(
                    title: items[i]['title'],
                    icon: items[i]['icon'],
                    path: items[i]['path'],
                  ),
              ],),

          ),

        ],
      ),
    );
  }
}

buildCarouselIndicator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for(int i = 0; i < imgList.length; i++)
        Container(
          margin: EdgeInsets.all(10),
          height: i == _currentPage ? 10 : 10,
          width: i == _currentPage ? 10 : 10,
          decoration: BoxDecoration(
            color: i == _currentPage ? Color(0xFF3283D5) : Color(0xFFD9D9D9),
            shape: BoxShape.circle,
          ),
        )
    ],
  );
}

