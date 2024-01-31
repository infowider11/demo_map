import 'package:demo_map/widget/round_edged_button.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'new_map_box_screen.dart';

String baseUrl = 'https://www.webwiders.in/WEB01/manish/';

class SelectRoutePage extends StatelessWidget {
  const SelectRoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 60,
            // )
            RoundEdgedButton(
              text: 'Way Of St. Francis',
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color: const Color(0xff6B7943),
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => MapboxMapExample(
                      fileUrl:
                          '${baseUrl}001WayofStFrancis-Florence-Assisi-Rome.gpx',
                      latlng: LatLng(43.681878, 12.116416),
                    ),
                  ),
                );
              },
            ),
            RoundEdgedButton(
              text: 'CaminoDeSantiago - Camino Frances For App',
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color: const Color(0xff6B7943),
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => MapboxMapExample(
                      fileUrl:
                          '${baseUrl}002CaminoDeSantiago-CaminoFrancesForApp.gpx',
                      latlng: LatLng(42.268711,-4.447974),
                    ),
                  ),
                );
              },
            ),
            RoundEdgedButton(
              text: 'Via Francigena For App',
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color: const Color(0xff6B7943),
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => MapboxMapExample(
                      fileUrl: '${baseUrl}003ViaFrancigenaForApp.gpx',
                      latlng: LatLng(49.571845, 3.633110),
                    ),
                  ),
                );
              },
            ),
            RoundEdgedButton(
              text: 'California Missions Trail For App',
              verticalMargin: 15,
              height: 65,
              fontSize: 20,
              color: const Color(0xff6B7943),
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => MapboxMapExample(
                      fileUrl: '${baseUrl}004CaliforniaMissionsTrailForApp.gpx',
                      latlng: LatLng(33.231983, -117.320050),
                      // latlng: LatLng(43.681878, 12.116416),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
