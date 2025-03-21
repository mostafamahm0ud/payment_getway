import 'package:flutter/material.dart';
import 'package:payment_getway/widgets/payment_method_widget.dart';

class ListPaymentMethod extends StatefulWidget {
  const ListPaymentMethod({super.key});

  @override
  _ListPaymentMethodState createState() => _ListPaymentMethodState();
}

class _ListPaymentMethodState extends State<ListPaymentMethod> {
  final List<Map<String, dynamic>> items = [
    {
      'icon': Icons.credit_card,
      'label': 'Credit Card',
      'isActive': true,
    },
    {
      'icon': Icons.paypal,
      'label': 'PayPal',
      'isActive': false,
    },
  ];

  void _toggleActiveState(int index) {
    setState(() {
      for (var item in items) {
        item['isActive'] = false;
      }
      items[index]['isActive'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: items.asMap().entries.map((entry) {
        int index = entry.key;
        var item = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: GestureDetector(
            onTap: () => _toggleActiveState(index),
            child: PaymentMethodWidget(
              icon: item['icon'],
              label: item['label'],
              isActive: item['isActive'],
            ),
          ),
        );
      }).toList(),
    );
  }
}