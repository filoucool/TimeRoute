import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'env.dart';
import 'time_counter.dart';
import 'stepper_modal_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeRoutes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late GoogleMapController mapController;
  bool _isModalVisible = false;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  final TextEditingController _currentAddressController = TextEditingController();
  final TextEditingController _destinationAddressController = TextEditingController();
  final TextEditingController _manualInputController = TextEditingController();

  void _toggleModal() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });

    if (_isModalVisible) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StepperModalDialog(
            onClose: () {
              setState(() {
                _isModalVisible = false;
              });
              Navigator.of(context).pop();
            },
            onGenerate: () {
              setState(() {
                _isModalVisible = false;
              });
              Navigator.of(context).pop();
            },
          );
        },
      ).then((_) {
        if (_isModalVisible) {
          setState(() {
            _isModalVisible = false;
          });
        }
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.setMapStyle('''
    [
      {
        "featureType": "poi",
        "elementType": "all",
        "stylers": [
          { "visibility": "off" }
        ]
      },
      {
        "featureType": "transit.station.airport",
        "elementType": "all",
        "stylers": [
          { "visibility": "off" }
        ]
      },
      {
        "featureType": "transit.station.rail",
        "elementType": "all",
        "stylers": [
          { "visibility": "off" }
        ]
      },
      {
        "featureType": "landscape.natural.terrain",
        "elementType": "all",
        "stylers": [
          { "visibility": "on" }
        ]
      },
      {
        "featureType": "landscape",
        "elementType": "labels",
        "stylers": [
          { "visibility": "off" }
        ]
      },
      {
        "featureType": "landscape.natural.landcover",
        "elementType": "all",
        "stylers": [
          { "visibility": "on" }
        ]
      }
    ]
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                      zoomControlsEnabled: false,
                      scrollGesturesEnabled: !_isModalVisible,
                      zoomGesturesEnabled: !_isModalVisible,
                    ),
                    if (_isModalVisible)
                      Positioned.fill(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.basic,
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: -40,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/TimeRoute1.svg',
                height: 150,
              ),
            ),
          ),
          if (_isModalVisible)
            Positioned.fill(
              child: ModalBarrier(
                color: Colors.black54,
                dismissible: false,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleModal,
        tooltip: 'Toggle Modal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
