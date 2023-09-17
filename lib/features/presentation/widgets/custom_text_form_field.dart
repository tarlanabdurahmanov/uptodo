import 'package:flutter/material.dart';
import 'package:todolistapp/shared/utils/font_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final String? hintText;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
    this.readOnly = false,
    this.obscureText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        obscureText: widget.obscureText,
        obscuringCharacter: '•',
        readOnly: widget.readOnly,
        focusNode: widget.focusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding ??
              (widget.prefixIcon != null
                  ? const EdgeInsets.only(right: 10)
                  : const EdgeInsets.only(right: 10, left: 10)),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(13),
                  child: widget.prefixIcon,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onSecondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.onSecondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: FontSize.details,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          fillColor: Theme.of(context).colorScheme.onBackground,
          filled: true,
        ),
      ),
    );
  }
}
