import 'dart:io';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

class MapBoxServices{

  // static Future parseGPXFile()async{


  static Future<String> getGPXString(String url)async{
    final temp =await  http.get(Uri.parse(url));
    // final temp =await  http.get(Uri.parse('https://www.webwiders.in/WEB01/manish/001WayofStFrancis-Florence-Assisi-Rome.gpx'));
    // final temp =await  http.get(Uri.parse('https://www.topografix.com/fells_loop.gpx'));
    print('the file23 is ${temp.body}');
    return temp.body;


  }

  static xml.XmlDocument getGPXDocument(){
    // final file = new File('assets/gpxfiles/001WayofStFrancis-Florence-Assisi-Rome.gpx');
    // file.exists().then((value){
    //   print('the file status is ${value}');
    // });
    // final file1 = new File('gpxfiles/001WayofStFrancis-Florence-Assisi-Rome.gpx');
    // file1.exists().then((value){
    //   print('the file1 status is ${value}');
    // });
    // final file2 = new File('assets/assets/gpxfiles/001WayofStFrancis-Florence-Assisi-Rome.gpx');
    // file2.exists().then((value){
    //   print('the file2 status is ${value}');
    // });


    // final file23 = File.fromUri(Uri.parse('https://www.topografix.com/fells_loop.gpx'));
    // file23.exists().then((value){
    //   print('the file23 status is ${value}');
    // });

    final file = new File('assets/gpxfiles/fells_loop.gpx');
    file.exists().then((value){
      print('the file status is ${value}');
    });
    final file1 = new File('gpxfiles/fells_loop.gpx');
    file1.exists().then((value){
      print('the file1 status is ${value}');
    });
    final file2 = new File('assets/assets/gpxfiles/fells_loop.gpx');
    file2.exists().then((value){
      print('the file2 status is ${value}');
    });


    final file3 = new File('assets/gpxfiles/fells_loop');
    file.exists().then((value){
      print('the file status is ${value}');
    });
    final file4 = new File('gpxfiles/fells_loop');
    file1.exists().then((value){
      print('the file1 status is ${value}');
    });
    final file5 = new File('assets/assets/gpxfiles/fells_loop');
    file2.exists().then((value){
      print('the file2 status is ${value}');
    });
    


    final document = xml.XmlDocument.parse(file.readAsStringSync());
    return document;
  }


  static  List<Map<String, double>> parseGPXFileFromString(String gpxData) {
    final document = xml.XmlDocument.parse(gpxData);

    List<Map<String, double>> coordinates = [];

    // Assuming waypoints are stored in <trkpt> elements
    for (final trkpt in document.findAllElements('trkpt')) {
      print('trkpt is found in the doc');
      final lat = double.parse(trkpt.getAttribute('lat') ?? '0');
      final lon = double.parse(trkpt.getAttribute('lon') ?? '0');

      coordinates.add({'lat': lat, 'lon': lon});
    }

    return coordinates;
  }
  static  List<Map<String, double>> parseGPXFileFromdocument(xml.XmlDocument document) {
      // final document = xml.XmlDocument.parse(gpxData);

      List<Map<String, double>> coordinates = [];

      // Assuming waypoints are stored in <trkpt> elements
      for (final trkpt in document.findAllElements('trkpt')) {
        final lat = double.parse(trkpt.getAttribute('lat') ?? '0');
        final lon = double.parse(trkpt.getAttribute('lon') ?? '0');

        coordinates.add({'lat': lat, 'lon': lon});
      }

      return coordinates;
  }


  static  List<LatLng> getLatLngFromString(String gpxData) {
    final document = xml.XmlDocument.parse(gpxData);

    List<LatLng> coordinates = [];

    // Assuming waypoints are stored in <trkpt> elements
    for (final trkpt in document.findAllElements('trkpt')) {
      final lat = double.parse(trkpt.getAttribute('lat') ?? '0');
      final lon = double.parse(trkpt.getAttribute('lon') ?? '0');

      coordinates.add(LatLng(lat, lon));
      // coordinates.add({'lat': lat, 'lon': lon});
    }

    return coordinates;
  }
}