import 'package:flutter/material.dart';

class HubBox extends StatefulWidget {
  HubBox({
    required this.title,
    required this.onLongPress,
    required this.onDelete,
  });

  final String title;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;

  @override
  _HubBoxState createState() => _HubBoxState();
}

class _HubBoxState extends State<HubBox> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onLongPressUp: () {
        setState(() {
          isPressed = true;
        });
        widget.onLongPress();
      },
      child: Listener(
        onPointerUp: (PointerUpEvent event) {
          setState(() {
            isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, isPressed ? -10 : 0, 0),
          width: width / 2.5,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 8),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isPressed)
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Image.asset(
                'assets/images/gateway.png',
                width: 60,
                height: 48,
              ),
              if (isPressed)
                Container(
                  width: 70,
                  height: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color.fromARGB(240, 233, 0, 0),
                    ),
                    iconSize: 20,
                    color: Color.fromARGB(199, 229, 15, 15),
                    onPressed: widget.onDelete,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
