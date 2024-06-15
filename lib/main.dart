import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'env.dart'; // Import the Env class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeRoute',
      home: const MyHomePage(title: 'TimeRoute Main Page'),
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
  final TextEditingController _manualInputController = TextEditingController(text: '0');

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
                title: Text('Modal Dialog'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _currentAddressController,
                      decoration: InputDecoration(labelText: 'Current Address'),
                    ),
                    TextField(
                      controller: _destinationAddressController,
                      decoration: InputDecoration(labelText: 'Destination Address'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _manualInputController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'Manual Input'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_upward),
                          onPressed: () {
                            int currentValue = int.parse(_manualInputController.text);
                            setState(() {
                              _manualInputController.text = (currentValue + 1).toString();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_downward),
                          onPressed: () {
                            int currentValue = int.parse(_manualInputController.text);
                            setState(() {
                              _manualInputController.text = (currentValue - 1).toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _toggleModal(); // Ensure the modal is toggled off
                    },
                    child: Text('Close'),
                  ),
                ],
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
      body: Center(
        child: Column(
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleModal,
        tooltip: 'Toggle Modal',
        child: const Icon(Icons.add),
      ),
    );
  }
}
