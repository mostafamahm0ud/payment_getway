import 'package:flutter/material.dart';
import 'package:payment_getway/widgets/custom_botton.dart';
import 'package:payment_getway/widgets/list_payment_method.dart';

class PaymentBottomModelSheet extends StatelessWidget {
  const PaymentBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        ListPaymentMethod(),
        CustomBotton(data: "Checkout", onPressed: () {}),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
