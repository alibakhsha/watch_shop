import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:watch_shop/constant/app_color.dart';
import 'package:watch_shop/constant/app_text_style.dart';

enum ButtonShape { rounded, rectangle }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonShape shape;
  final bool fullWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.shape,
    this.fullWidth = false,
  });

  OutlinedBorder _getButtonShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(shape == ButtonShape.rounded ? 80 : 8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return fullWidth
        ? SizedBox(width: double.infinity, child: _buildButton())
        : IntrinsicWidth(child: _buildButton());
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        backgroundColor: AppColor.bgButtonColor,
        shape: _getButtonShape(),
      ),
      child: Center(child: Text(text, style: AppTextStyle.textButtonStyle)),
    );
  }
}
