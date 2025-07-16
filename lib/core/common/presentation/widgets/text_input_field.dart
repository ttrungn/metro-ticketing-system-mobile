import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.icon,
    required this.labelText,
    required this.prefixIcon,
    required this.errorText,
    required this.focusColor,
    required this.unfocusColor,
    this.initialObscure = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final IconData icon;
  final String labelText;
  final IconData prefixIcon;
  final String? errorText;
  final Color focusColor;
  final Color unfocusColor;
  final bool initialObscure;

  @override
  State<StatefulWidget> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure = widget.initialObscure;
  }

  Color _getIconColor(FocusNode node) =>
      node.hasFocus ? widget.focusColor : widget.unfocusColor;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: isObscure,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color:
              widget.focusNode.hasFocus
                  ? widget.focusColor
                  : widget.unfocusColor,
        ),
        prefixIcon: Icon(widget.icon, color: _getIconColor(widget.focusNode)),
        suffixIcon:
            widget.initialObscure
                ? Tooltip(
                  message: isObscure ? 'Show' : 'Hide',
                  child: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      color: _getIconColor(widget.focusNode),
                    ),
                    onPressed: () => setState(() => isObscure = !isObscure),
                  ),
                )
                : null,
        errorText: widget.errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: widget.unfocusColor, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: widget.focusColor, width: 2.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: widget.unfocusColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.5),
        ),
      ),
    );
  }
}
