import 'package:demo_map/widget/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'new_map_box_screen.dart';
import 'osm_map repo_example.dart';
import 'osm_map_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Home"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundEdgedButton(
              text: "OsmMap example",
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (c)=> OldMainExample()));
              },
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color:const Color(0xff6B7943) ,
              fontWeight: FontWeight.w600,
            ),
            RoundEdgedButton(
              text: "Osm Map",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>const OsmMapScreen()));
              },
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color:const Color(0xff6B7943) ,
              fontWeight: FontWeight.w600,
            ),
            RoundEdgedButton(
              text: "Map box Map",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (c)=>MapboxMapExample()));
              },
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color:const Color(0xff6B7943) ,
              fontWeight: FontWeight.w600,
            ),
            Image.asset('assets/marker.png',width: 200,)
          ],
        ),
      ),
    );
  }
}
