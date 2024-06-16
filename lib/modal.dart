import 'package:flutter/material.dart';
import 'time_counter.dart';

class ModalDialog extends StatelessWidget {
  final TextEditingController currentAddressController;
  final TextEditingController destinationAddressController;
  final TextEditingController manualInputController;
  final VoidCallback onClose;
  final VoidCallback onGenerate;

  ModalDialog({
    required this.currentAddressController,
    required this.destinationAddressController,
    required this.manualInputController,
    required this.onClose,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Modal Dialog', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: currentAddressController,
            decoration: InputDecoration(
              labelText: 'Current Address',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: destinationAddressController,
            decoration: InputDecoration(
              labelText: 'Destination Address',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          SizedBox(height: 10),
          TimeCounter(controller: manualInputController),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onClose,
          child: Text('Close', style: TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: onGenerate,
          child: Text('Generate', style: TextStyle(color: Colors.green)),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }
}
