import 'package:flutter/material.dart';
import 'package:payment_getway/features/cheakout/presentation/widgets/custom_bottun_sheet_consumer.dart';
import 'package:payment_getway/features/cheakout/presentation/widgets/list_payment_method.dart';

class PaymentBottomModelSheet extends StatelessWidget {
  const PaymentBottomModelSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 5,
      children: [
        ListPaymentMethod(),
        CustomButtonConsumer(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
