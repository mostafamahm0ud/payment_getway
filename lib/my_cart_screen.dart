import 'package:flutter/material.dart';
import 'package:payment_getway/widgets/payment_bottom_model_sheet.dart';

class MycartScreen extends StatelessWidget {
  const MycartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "My Cart",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.greenAccent),
      body: const Center(
        child: Text("My Cart"),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                builder: (context) {
                  return const PaymentBottomModelSheet();
                });
          },
          child: const Icon(Icons.payment)),
    );
  }
}
