import 'package:flutter/material.dart';

class HubBox extends StatefulWidget {
  HubBox({
    required this.title,
    required this.onLongPress,
    required this.onDelete,
    required this.doubleTab,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onLongPress;
  final VoidCallback doubleTab;
  final VoidCallback onDelete;
  final bool isSelected;

  @override
  _HubBoxState createState() => _HubBoxState();
}

class _HubBoxState extends State<HubBox> {
  bool isPressed = false;
  Color myColor = Colors.white;
  bool doubletab = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        setState(() {
          doubletab = !doubletab;
          if (doubletab == true) {
            widget.doubleTab();
          }

          myColor = doubletab ? Colors.blue : Colors.white;
        });
      },
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
            color: widget.isSelected ? Colors.blue : Colors.white,
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
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Image.asset(
                'assets/images/gateway.png',
                width: 60,
                height: 40,
              ),
              if (isPressed)
                Container(
                  width: 70,
                  height: 40,
                  child: GestureDetector(
                    onTap: widget.onDelete,
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: Color.fromARGB(240, 233, 0, 0),
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
