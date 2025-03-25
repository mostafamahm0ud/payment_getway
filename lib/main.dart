import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_getway/core/utils/api_keys.dart';
import 'package:payment_getway/features/cheakout/presentation/my_cart_screen.dart';

void main() {
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const PaymentGetwayApp(),
  //     enabled: true,
  //   ),
  // );
  Stripe.publishableKey = PaymentApiKeys.stripePublishableKey;
  runApp(const PaymentGetwayApp());
}

class PaymentGetwayApp extends StatelessWidget {
  const PaymentGetwayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MycartScreen(),
    );
  }
}
