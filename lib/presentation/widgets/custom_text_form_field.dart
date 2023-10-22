import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {super.key,
      this.isObscure = false,
      required this.isPassword,
      this.hintText,
      this.controller});

  bool? isObscure;
  final bool isPassword;
  final String? hintText;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isObscure ?? false,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    widget.isObscure = !widget.isObscure!;
                    setState(() {});
                  },
                  icon: Icon(
                    widget.isObscure ?? false
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Colors.grey,
                  ))
              : null,
          hintText: widget.hintText,
          fillColor: Colors.grey[100],
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
