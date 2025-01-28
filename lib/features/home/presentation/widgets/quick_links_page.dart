import 'package:flutter/material.dart';

import '../../../../utils/functions.dart';

class QuickLinksPage extends StatelessWidget {
  QuickLinksPage({super.key});

  final Map<String, List<List<String>>> iitMandiLinks = {
    "Institute": [
      ["IIT Mandi Website", "https://www.iitmandi.ac.in/"],
      ["Student Gymkhana", "https://iitmandi.co.in/"]
    ],
    "Academic": [
      ["UG Academic", "https://iitmandi.co.in/ug_acad.html"],
      ["PG Academic", "https://iitmandi.co.in/pg_acad.html"],
    ],
    "Technical Society": [
      ["Society Website", "https://iitmandi.co.in/technical.html"],
      ["Kamand Prompt", "https://pc.iitmandi.co.in/"],
      ["Robotronics", "https://robotronics.iitmandi.co.in/"],
      ["STAC", "https://stac.iitmandi.co.in/"],
      ["Yantrik", "https://yantrik.iitmandi.co.in/"],
      ["Nirmaan", "https://nirmaan.iitmandi.co.in/"],
      ["SAE", "https://clubsae.iitmandi.co.in/about-us"],
      ["E-cell", "https://ecell.iitmandi.co.in/"],
      ["KBG", "https://www.instagram.com/kbg_iitmandi/"],
    ],
    'Others': [
      ["Cultural Society", "https://iitmandi.co.in/cultural.html"],
      ["Sports Society", "https://iitmandi.co.in/sports.html"],
      ["Literary Society", "https://iitmandi.co.in/literary.html"],
      ["Hostel Affairs", "https://iitmandi.co.in/hostel.html"],
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<String> keys = iitMandiLinks.keys.toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title:
            Text("Quick Links", style: Theme.of(context).textTheme.bodyMedium),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView.separated(
            itemCount: iitMandiLinks.length,
            itemBuilder: (context, idx) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(keys[idx],
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  for (int i = 0; i < iitMandiLinks[keys[idx]]!.length; i++)
                    GestureDetector(
                        onTap: () {
                          launchURL(iitMandiLinks[keys[idx]]![i][1]);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              iitMandiLinks[keys[idx]]![i][0],
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(fontSize: 17),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                          ],
                        )),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 2,
                color: Theme.of(context).colorScheme.scrim,
              );
            }),
      ),
    );
  }
}
