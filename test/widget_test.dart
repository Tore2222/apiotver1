import 'package:flutter/material.dart';

class IoTDeviceControlWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const IoTDeviceControlWidget({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        iconSize: 80,
        onPressed: onPressed,
      ),
    );
  }
}
Container(
                          margin: const EdgeInsets.all(5),
                          width: double.infinity,
                          height: 100,
                          color: Colors.grey,
                          child: Center(
                            child: Text(
                              'Hộp ${(row * 2) + 2}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),