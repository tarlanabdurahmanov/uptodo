import 'package:flutter/material.dart';
import '../../../shared/utils/font_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final String? hintText;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool obscureText;
  final bool isBorderNone;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.hintText,
    this.contentPadding,
    this.prefixIcon,
    this.focusNode,
    this.readOnly = false,
    this.obscureText = false,
    this.isBorderNone = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLines: 4,
        minLines: 1,
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
          border: widget.isBorderNone
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
          enabledBorder: widget.isBorderNone
              ? InputBorder.none
              : OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
          focusedBorder: widget.isBorderNone
              ? InputBorder.none
              : OutlineInputBorder(
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
