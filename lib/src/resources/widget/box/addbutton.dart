import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  @override
  _AddButtonState createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  bool _showOptions = false;

  void _toggleOptions() {
    setState(() {
      _showOptions = !_showOptions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: _toggleOptions,
          child: Text('Add'),
        ),
        if (_showOptions)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nhấn nút "add1"
                },
                child: Text('Add1'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Xử lý khi nhấn nút "add2"
                },
                child: Text('Add2'),
              ),
            ],
          ),
      ],
    );
  }
}
