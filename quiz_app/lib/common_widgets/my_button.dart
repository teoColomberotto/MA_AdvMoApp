import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final double fontSize;
  final double padding;
  final double margin;
  final Color outlineColor;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback? onPressed;
  final bool disabled;

  const MyButton({
    Key? key,
    required this.text,
    this.icon,
    this.fontSize = 18,
    this.padding = 16,
    this.margin = 8,
    this.outlineColor = Colors.black,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.black,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  MyButtonState createState() => MyButtonState();
}

class MyButtonState extends State<MyButton> {
  bool _hovering = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final disabledColor = Colors.grey.shade400;
    final textColor = widget.disabled ? disabledColor : Colors.white;
    final borderColor = widget.disabled ? disabledColor : widget.outlineColor;

    return MouseRegion(
      onHover: (event) => setState(() => _hovering = true),
      onExit: (event) => setState(() => _hovering = false),
      child: GestureDetector(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: borderColor, width: 1),
          ),
          borderOnForeground: false,
          clipBehavior: Clip.antiAlias,
          color: widget.disabled ? disabledColor : widget.backgroundColor,
          child: InkWell(
            onTap: widget.disabled ? null : widget.onPressed,
            onLongPress: () => {
              setState(() => _isPressed = true),
              HapticFeedback.mediumImpact(),
            },
            onTapCancel: () => setState(() => _isPressed = false),
            onTapUp: (_) => setState(() => _isPressed = false),
            child: Container(
              padding: EdgeInsets.all(widget.padding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null)
                    Icon(
                      widget.icon,
                      color: textColor,
                    ),
                  if (widget.text != null && widget.icon != null)
                    const SizedBox(width: 8),
                  if (widget.text != null)
                    Text(
                      widget.text!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Pokemon',
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
