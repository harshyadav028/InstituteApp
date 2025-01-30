import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final bool isGuest;
  const Dashboard({super.key, required this.isGuest});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Widget _buildGridCard(String title, IconData icon) {
    return SizedBox(
      child:InkWell(
        onTap: (){
        },
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            color: Colors.blue,
            elevation: 4,
            child:  Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 25, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white,fontSize: 17, fontWeight: FontWeight.w600), ),],),),),
        ),
      ),
    );}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
            
              Stack(
                alignment: Alignment.center,
              children: [
                 Positioned(
                  top: MediaQuery.of(context).size.height * .40,
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
                           physics: NeverScrollableScrollPhysics(),
                          children: [
                            _buildGridCard('Lost/Found', Icons.card_travel),
                            _buildGridCard('Buy/Sell', Icons.shopping_cart_outlined),
                            _buildGridCard('Maps', Icons.map_outlined),
                            _buildGridCard('Calendar', Icons.calendar_today_outlined),
                            _buildGridCard('Events', Icons.menu),
                            _buildGridCard('Mess Menu', Icons.restaurant),],),
                    
                                   ),
                                   
                                 ],
                                 ),
                 ),
                  
              ],
              ),
            
            
    );
  }
}

