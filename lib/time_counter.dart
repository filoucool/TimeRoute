import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {
  final TextEditingController controller;

  TimeCounter({required this.controller});

  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  int hours = 0;
  int minutes = 0;

  void _incrementTime() {
    setState(() {
      minutes += 15;
      if (minutes >= 60) {
        hours += 1;
        minutes = 0;
      }
      _updateController();
    });
  }

  void _decrementTime() {
    setState(() {
      minutes -= 15;
      if (minutes < 0) {
        if (hours > 0) {
          hours -= 1;
          minutes = 45;
        } else {
          minutes = 0;
        }
      }
      _updateController();
    });
  }

  void _updateController() {
    widget.controller.text = '${hours.toString().padLeft(2, '0')}h : ${minutes.toString().padLeft(2, '0')} mins';
  }

  @override
  void initState() {
    super.initState();
    _updateController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: _incrementTime,
              ),
              IconButton(
                icon: Icon(Icons.arrow_downward),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: _decrementTime,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
