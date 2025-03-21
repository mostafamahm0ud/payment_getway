import 'package:flutter/material.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
    required this.icon,
    required this.label,
    this.isActive = false, 
  });

  final IconData? icon;
  final String label;
  final bool isActive; 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? Colors.greenAccent : Colors.white, 
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? Colors.green : Colors.greenAccent, 
          // width: isActive ? 2 : 1, 
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          spacing: 10,
          children: [
            Icon(
              icon ?? Icons.credit_card,
              size: 24,
              color: isActive ? Colors.white : Colors.black, 
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : Colors.black, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}