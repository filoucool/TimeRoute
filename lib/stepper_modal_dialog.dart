import 'package:flutter/material.dart';

class StepperModalDialog extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onGenerate;

  StepperModalDialog({
    required this.onClose,
    required this.onGenerate,
  });

  @override
  _StepperModalDialogState createState() => _StepperModalDialogState();
}

class _StepperModalDialogState extends State<StepperModalDialog> {
  int _currentStep = 0;
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());

  void _nextStep() {
    if (_currentStep < 4) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.directions_walk),
          SizedBox(width: 10),
          Text('Step ${_currentStep + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter the starting address'),
            TextField(
              controller: _controllers[_currentStep],
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
      actions: [
        if (_currentStep > 0)
          TextButton(
            onPressed: _previousStep,
            child: Text('Previous'),
          ),
        if (_currentStep < 4)
          TextButton(
            onPressed: _nextStep,
            child: Text('Next'),
          ),
        if (_currentStep == 4)
          TextButton(
            onPressed: widget.onGenerate,
            child: Text('Generate', style: TextStyle(color: Colors.green)),
          ),
        TextButton(
          onPressed: widget.onClose,
          child: Text('Close', style: TextStyle(color: Colors.red)),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }
}
