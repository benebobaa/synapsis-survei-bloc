import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {super.key,
      required this.title,
      required this.isOutlined,
      required this.onPressed,
      this.height = 45,
      this.icon,
      this.currentQuestion = 1,
      this.totalQuestion = 0,
      this.currentPosition});

  final String title;
  final bool isOutlined;
  final VoidCallback onPressed;
  final double height;
  final IconData? icon;
  final int? currentQuestion;
  final int? totalQuestion;
  final bool? currentPosition;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: currentPosition ?? false ? 2 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        backgroundColor: (icon != null)
            ? Colors.black
            : isOutlined
                ? Colors.white
                : Colors.blue,
        minimumSize: Size(double.infinity, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        side: BorderSide(
          color: isOutlined ? Colors.blue : Colors.transparent,
          width: 1.5,
        ),
      ),
      onPressed: onPressed,
      child: (icon != null && currentQuestion != null)
          ? Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: Colors.white,
                ),
                const SizedBox(width: 2),
                Text(
                  '$currentQuestion/$totalQuestion',
                  style: TextStyle(
                      color: isOutlined ? Colors.blue : Colors.white,
                      fontSize: 12),
                ),
              ],
            )
          : Text(
              title,
              style: TextStyle(color: isOutlined ? Colors.blue : Colors.white),
            ),
    );
  }
}
