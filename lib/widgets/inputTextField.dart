import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    this.label = "",
    this.content = "", // Retained the content property
    this.readOnly = false,
    this.width = 320,
    this.height = 40,
    this.hintText = "",
    this.controller, // Added the controller property
    this.obscureText = false, 
  });

  final double width;
  final double height;
  final String label;
  final String content; // Keep the content property
  final bool readOnly;
  final String hintText;
  final TextEditingController? controller; // Make this optional
  final bool obscureText;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  TextEditingController? _internalController;

  @override
  void initState() {
    super.initState();
    // Initialize an internal controller if none is provided, with content as its text
    _internalController = widget.controller ?? TextEditingController(text: widget.content);
  }

  @override
  void didUpdateWidget(InputTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the widget is updated and a new external controller is provided, switch to it
    // Note: This does not handle updating 'content' on the fly; such changes won't be reflected
    if (widget.controller != oldWidget.controller) {
      _internalController = widget.controller ?? TextEditingController(text: widget.content);
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Only dispose the internally created controller
    if (widget.controller == null) {
      _internalController?.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        readOnly: widget.readOnly,
        controller: _internalController,
        textAlign: TextAlign.center,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hintText,
          fillColor: const Color.fromRGBO(238, 242, 255, 1),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 7, 20, 10),
        ),
      ),
    );
  }
}