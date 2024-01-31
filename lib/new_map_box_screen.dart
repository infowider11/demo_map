
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:demo_map/map_box_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // ignore: unnecessary_import
import 'package:mapbox_gl/mapbox_gl.dart';






import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapboxMapExample extends StatefulWidget {
  String fileUrl;
  final LatLng latlng;


  MapboxMapExample({required this.fileUrl, required this.latlng});

  @override
  _MapboxMapExampleState createState() => _MapboxMapExampleState();
}

class _MapboxMapExampleState extends State<MapboxMapExample> {
  MapboxMapController? mapController;
  final String accessToken = 'pk.eyJ1IjoicGlsZ3JpbXBhdGhzIiwiYSI6ImNscXNqMmZpMTNqaHAya3J5Z2pxNjU0anEifQ.Dt_-sO8MDKb4xEm2N3ZlEw'; // Replace with your Mapbox access token

 List<dynamic> serviceList=[
   {'lantLong': const LatLng(22.6980, 75.8683),'img':'assets/marker.png'},
   { 'lantLong': const LatLng(22.6963, 75.8875), 'img': 'assets/marker.png'},
   {'lantLong': const LatLng(22.6845, 75.8645), 'img': 'assets/marker.png'},
   {'lantLong': const LatLng(22.7082, 75.8757), 'img': 'assets/marker.png'}

 ];

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1),(){
      drawPath();
      mapController!.addSymbols(
          List.generate(serviceList.length, (index) =>   SymbolOptions(
            geometry:  serviceList[index]['lantLong'],
            iconImage: serviceList[index]['img'],// Specify your custom marker image without the file extension
            iconSize: 0.7, // Adjust the size of the marker
          ))
      );
    });

    super.initState();
  }
  // List<LatLng> pathPoints = [
  //   LatLng(22.6980, 75.8683),
  //   LatLng(22.6963, 75.8875) // Point B
  // ];
  void drawPath() {

    mapController!.addLineLayer(
      'fills',
      'lines',
      LineLayerProperties(
        lineColor: Colors.blue.toHexStringRGB(),
    lineCap: 'round',
    lineJoin: 'round',
    lineWidth: 3,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox'),
      ),
      body: MapboxMap(
        accessToken: accessToken,
        onMapCreated: _onMapCreated,
        

        initialCameraPosition:  CameraPosition(
          target: widget.latlng, // San Francisco coordinates
          // target: LatLng(43.681878, 12.116416), // San Francisco coordinates
          // target: LatLng(22.6980, 75.8683), // San Francisco coordinates
          zoom: 13.0,
        ),

        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
        

      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    setState(() {
      mapController = controller;
    });
     MapBoxServices.getGPXString(widget.fileUrl).then((value){
       print('sdfadsfasdsfas $value');
       var sd = MapBoxServices.parseGPXFileFromString(value);
       log('sdfadsfas $sd');
       List<LatLng> latLongList = List.generate(sd.length, (index) => LatLng(sd[index]['lat']!, sd[index]['lon']!));
       mapController!.addLines(
         [
         LineOptions(
           geometry: latLongList

         ),
         ]
       );
     });

    // mapController!.addLineLayer(
    //     'fills',
    //     'lines',
    //     LineLayerProperties(
    //       lineColor: Colors.blue.toHexStringRGB(),
    //       lineCap: 'round',
    //       lineJoin: 'round',
    //       lineWidth: 3,
    //     )
    // );



    // mapController.adds
    // mapController.addT
  }
}