import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_getway/features/cheakout/data/repo/checkout_repo_impl.dart';
import 'package:payment_getway/features/cheakout/presentation/manager/cubit/strip_payment_cubit_cubit.dart';
import 'package:payment_getway/features/cheakout/presentation/widgets/payment_bottom_model_sheet.dart';

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
      ),
      body: const Center(
        child: Text("My Cart"),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                builder: (context) {
                  return BlocProvider(
                    create: (context) =>
                        StripPaymentCubitCubit(CheckoutRepoImpl()),
                    child: PaymentBottomModelSheet(),
                  );
                });
          },
          child: const Icon(Icons.payment)),
    );
  }
}
