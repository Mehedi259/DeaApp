import 'package:flutter/material.dart';
import 'package:mobile_app_dea/themes/create_qutes.dart';

class InputCardWidget extends StatelessWidget {
  final double scale;
  final TextEditingController? controller;
  final String? initialValue;

  const InputCardWidget({
    super.key, 
    this.scale = 1.0, 
    this.controller,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    // Create controller with initial value if provided
    final effectiveController = controller ?? 
      (initialValue != null ? TextEditingController(text: initialValue) : null);
    
    return Container(
      height: 160,
      width: double.infinity,
      padding: EdgeInsets.all(14 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14 * scale),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8 * scale,
          ),
        ],
      ),
      child: TextField(
        controller: effectiveController,
        decoration: InputDecoration(
          hintText: 'Write down your \n quest...',
          hintStyle: AppTextStylesQutes.workSansExtraBold32,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
