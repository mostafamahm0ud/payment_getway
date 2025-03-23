import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:payment_getway/my_cart_screen.dart';

void main() {
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const PaymentGetwayApp(),
  //     enabled: true,
  //   ),
  // );
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
