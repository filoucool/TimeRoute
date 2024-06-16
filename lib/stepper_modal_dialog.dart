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
  final PageController _pageController = PageController();
  final List<TextEditingController> _controllers = List.generate(5, (_) => TextEditingController());
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 4) {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          children: [
            // Title Row
            Row(
              children: [
                Icon(Icons.directions_walk),
                SizedBox(width: 10),
                Text('Step ${_currentStep + 1}', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),

            // Content Row
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildStep1(),
                  _buildStep2(),
                  _buildStep3(),
                  _buildStep4(),
                  _buildStep5(),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Navigation Row
            Row(
              children: [
                // Previous Button
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _currentStep > 0
                        ? ElevatedButton(
                            onPressed: _previousStep,
                            child: Text('Previous'),
                          )
                        : SizedBox.shrink(),
                  ),
                ),
                // Generate Button
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _currentStep == 4
                        ? ElevatedButton(
                            onPressed: widget.onGenerate,
                            child: Text('Generate'),
                          )
                        : SizedBox.shrink(),
                  ),
                ),
                // Next Button
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: _currentStep < 4
                        ? ElevatedButton(
                            onPressed: _nextStep,
                            child: Text('Next'),
                          )
                        : SizedBox.shrink(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: widget.onClose,
                child: Text('Close', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildStep1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on, size: 100),
        Text('Step 1: Current Address', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(
          controller: _controllers[0],
          decoration: InputDecoration(
            labelText: 'Current Address',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.flag, size: 100),
        Text('Step 2: Destination Address', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(
          controller: _controllers[1],
          decoration: InputDecoration(
            labelText: 'Destination Address',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time, size: 100),
        Text('Step 3: Time', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(
          controller: _controllers[2],
          decoration: InputDecoration(
            labelText: 'Time',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.directions_car, size: 100),
        Text('Step 4: Transportation Mode', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(
          controller: _controllers[3],
          decoration: InputDecoration(
            labelText: 'Transportation Mode',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.description, size: 100),
        Text('Step 5: Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(
          controller: _controllers[4],
          decoration: InputDecoration(
            labelText: 'Summary',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ],
    );
  }
}
