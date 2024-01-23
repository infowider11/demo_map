import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'osm_map repo_example.dart';

class OsmMapScreen extends StatefulWidget {
  const OsmMapScreen({Key? key}) : super(key: key);

  @override
  State<OsmMapScreen> createState() => _OsmMapScreenState();
}

class _OsmMapScreenState extends State<OsmMapScreen> with OSMMixinObserver, TickerProviderStateMixin {
  late MapController controller;
   GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();
  Key mapGlobalkey = UniqueKey();

  List<GeoPoint> pointsRoad = [];
  @override
  Future<void> mapIsReady(bool isReady) async {
    if (isReady) {
      await mapIsInitialized();
    }
  }

  Future<void> mapIsInitialized() async {
    await controller.setZoom(zoomLevel: 12);
    await controller.setMarkerOfStaticPoint(
      id: "line 2",
      markerIcon: const MarkerIcon(
        icon: Icon(
          Icons.train,
          color: Colors.orange,
          size: 36,
        ),
      ),
    );

    await controller.setStaticPosition(
      [
        GeoPointWithOrientation(
          latitude: 22.6963,
          longitude: 75.8875,
          angle: pi / 4,
        ),
        GeoPointWithOrientation(
          latitude: 22.6845,
          longitude: 75.8645,
          angle: pi / 2,
        ),
      ],
      "line 2",
    );
    final bounds = await controller.bounds;
    print(bounds.toString());
    // Future.delayed(Duration(seconds: 5), () {
    //   controller.changeTileLayer(tileLayer: CustomTile.cycleOSM());
    // });
  }

  marker() async{
    controller = MapController.withPosition(
        initPosition: GeoPoint(
          latitude: 22.6980,
          longitude: 75.8683,
        ),);
    controller.addObserver(this);
    controller.listenerMapSingleTapping.addListener(() async {
      if (controller.listenerMapSingleTapping.value != null) {
        print('-lcoation1------${controller.listenerMapSingleTapping.value}');

          pointsRoad.add(controller.listenerMapSingleTapping.value!);
          await controller.addMarker(
            controller.listenerMapSingleTapping.value!,
            markerIcon: MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.amber,
                size: 48,
              ),
            ),
          );
          if (pointsRoad.length >= 2 ) {
            roadActionBt(context);

        }
      }
    });

  }

  void initState() {
    super.initState();
    // controller = MapController.withUserPosition(
    //     trackUserLocation: UserTrackingOption(
    //   enableTracking: true,
    //   unFollowUser: false,
    // )
    controller = MapController.withPosition(
      initPosition: GeoPoint(
        latitude: 22.6980,
        longitude: 75.8683,
      ),
    );
    controller.addObserver(this);
    scaffoldKey = GlobalKey<ScaffoldState>();
    controller.listenerMapSingleTapping.addListener(() async {
      if (controller.listenerMapSingleTapping.value != null) {
        print('-lcoation1------${controller.listenerMapSingleTapping.value}');
          pointsRoad.add(controller.listenerMapSingleTapping.value!);
          await controller.addMarker(
            controller.listenerMapSingleTapping.value!,
            markerIcon: const MarkerIcon(
              icon: Icon(
                Icons.person_pin_circle,
                color: Colors.amber,
                size: 48,
              ),
            ),
          );
          if (pointsRoad.length >= 2 ) {
            roadActionBt(context);
          }

      }
    });


    // controller.listenerMapIsReady.addListener(mapIsInitialized);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( key: scaffoldKey,
      appBar: AppBar(
        title: const Text(
          "Osm Map"
        ),
      ),
      floatingActionButton: PointerInterceptor(
        child: FloatingActionButton(
          key: UniqueKey(),
          heroTag: "locationUser",
          onPressed: () async {

              await controller.currentLocation();
              await controller.enableTracking(
                enableStopFollow: true,
                disableUserMarkerRotation: false,
                anchor: Anchor.left,
              );
              //await controller.zoom(5.0);

          },
          child: const Icon(Icons.my_location),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: OSMFlutter(
              controller:controller,
              mapIsLoading: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Map is Loading.."),
                  ],
                ),
              ),
              onMapIsReady: (isReady) {if (isReady) {
                  print("map is ready");
                }},
              osmOption: OSMOption(
                enableRotationByGesture: true,
                showDefaultInfoWindow: false,
                zoomOption: const ZoomOption(
                  initZoom: 8,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                    personMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.my_location,
                        color: Colors.blueAccent,
                        size: 80,
                      ),
                    ),
                    directionArrowMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.navigation_rounded,
                        size: 100,
                      ),
                    )
                ),
                staticPoints: [
                  StaticPositionGeoPoint(
                    "line 1",
                    const MarkerIcon(
                      icon: Icon(
                        Icons.train,
                        color: Colors.green,
                        size: 32,
                      ),
                    ),
                    [
                      GeoPoint(
                        latitude: 22.6845,
                        longitude: 75.8645,
                      ),
                      GeoPoint(
                        latitude: 22.7082,
                        longitude:75.8757,
                      ),
                    ],
                  ),
                ],
                roadConfiguration: const RoadOption(
                  roadColor: Colors.blueAccent,
                ),
                markerOption: MarkerOption(
                    defaultMarker: const MarkerIcon(
                      icon: Icon(
                        Icons.location_on_sharp,
                        color: Colors.blue,
                        size: 100,
                      ),
                    )
                ),
              ),
            ),
          )

        ],
      ),
    );
  }

  void roadActionBt(BuildContext ctx) async {
    try {
      ValueNotifier<RoadType> notifierRoadType = ValueNotifier(RoadType.car);

      final bottomPersistant = scaffoldKey.currentState!.showBottomSheet(
            (ctx) {
          return PointerInterceptor(
            child: RoadTypeChoiceWidget(
              setValueCallback: (roadType) {
                notifierRoadType.value = roadType;
              },
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
      await bottomPersistant.closed.then((roadType) async {
        double distanceEnMetres = await distance2point(  pointsRoad.first,
          pointsRoad.last,);
        RoadInfo roadInformation = await controller.drawRoad(
          pointsRoad.first,
          pointsRoad.last,
          roadType: notifierRoadType.value,
          intersectPoint: pointsRoad.getRange(1, pointsRoad.length - 1).toList(),
          roadOption: const RoadOption(
            roadWidth: 20,
            roadColor: Colors.blue,
            zoomInto: true,
          ),
        );
        pointsRoad.clear();
        debugPrint(
            "app distanceEnMetres:${distanceEnMetres} ");
        debugPrint(
            "app duration:${roadInformation.duration} ");
        debugPrint("app distance:${roadInformation.distance}Km");
        debugPrint("app road information:" + roadInformation.toString());
        final console = roadInformation.instructions.map((e) => e.toString()).reduce((value, element) => "$value -> \n $element",).toString();
        debugPrint(console, wrapWidth: console.length,
        );
        // final box = await BoundingBox.fromGeoPointsAsync(pointsRoad.first);
        // controller.zoomToBoundingBox(
        //   box,
        //   paddinInPixel: 64,
        // );
      });
    } on RoadException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${e.errorMessage()}",
          ),
        ),
      );
    }
  }

}
