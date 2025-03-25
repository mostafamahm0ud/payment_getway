import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_input_model.dart';
import 'package:payment_getway/features/cheakout/presentation/manager/cubit/strip_payment_cubit_cubit.dart';
import 'package:payment_getway/features/cheakout/presentation/my_cart_screen.dart';
import 'package:payment_getway/features/cheakout/presentation/widgets/custom_botton.dart';

class CustomButtonConsumer extends StatelessWidget {
  const CustomButtonConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripPaymentCubitCubit, StripPaymentCubitState>(
      listener: (context, state) {
        if (state is StripPaymentCubitSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MycartScreen()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Payment Success"),
            ),
          );
        }
        if (state is StripPaymentCubitFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomBotton(
            isLoading: state is StripPaymentCubitLoading ? true : false,
            data: "Checkout",
            onPressed: () {
              PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                amount: "100",
                currency: "USD",
                customerId: 'cus_S0agI7o7rbXbHl',
              );
              BlocProvider.of<StripPaymentCubitCubit>(context).makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);
            });
      },
    );
  }
}
