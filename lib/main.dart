import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'env.dart';
import 'time_counter.dart';

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
  int _counter = 1000;
  late GoogleMapController mapController;
  bool _isModalVisible = false;
  final LatLng _center = const LatLng(45.521563, -122.677433);

  final TextEditingController _currentAddressController = TextEditingController();
  final TextEditingController _destinationAddressController = TextEditingController();
  final TextEditingController _manualInputController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleModal() {
    setState(() {
      _isModalVisible = !_isModalVisible;
    });

    if (_isModalVisible) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Modal Dialog', style: TextStyle(fontWeight: FontWeight.bold)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _currentAddressController,
                      decoration: InputDecoration(
                        labelText: 'Current Address',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _destinationAddressController,
                      decoration: InputDecoration(
                        labelText: 'Destination Address',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    SizedBox(height: 10),
                    TimeCounter(controller: _manualInputController),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _toggleModal();
                    },
                    child: Text('Close', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {
                      _toggleModal();
                    },
                    child: Text('Generate', style: TextStyle(color: Colors.green)),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                backgroundColor: Colors.white,
              );
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
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 11.0,
                  ),
                  zoomControlsEnabled: false,
                ),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SvgPicture.asset(
                'assets/TimeRoute1.svg',
                height: 150,
              ),
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
