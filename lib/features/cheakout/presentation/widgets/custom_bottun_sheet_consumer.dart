import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_getway/core/utils/api_keys.dart';
import 'package:payment_getway/features/cheakout/data/model/pay_pal_amount_model/details.dart';
import 'package:payment_getway/features/cheakout/data/model/pay_pal_amount_model/pay_pal_amount_model.dart';
import 'package:payment_getway/features/cheakout/data/model/pay_pal_items_list_model/item.dart';
import 'package:payment_getway/features/cheakout/data/model/pay_pal_items_list_model/pay_pal_items_list_model.dart';
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
              // PaymentIntentInputModel paymentIntentInputModel =
              //     PaymentIntentInputModel(
              //   amount: "100",
              //   currency: "USD",
              //   customerId: 'cus_S0agI7o7rbXbHl',
              // );
              // BlocProvider.of<StripPaymentCubitCubit>(context).makePayment(
              //     paymentIntentInputModel: paymentIntentInputModel);

              payPalNavigator(context);
            });
      },
    );
  }

  void payPalNavigator(BuildContext context) {
    final order = getTransactionOrder();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: PaymentApiKeys.clientId,
        secretKey: PaymentApiKeys.paypalSecret,
        transactions: [
          {
            "amount": order.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": {
              "items": order.payPalItemsListModel.items!
                  .map((item) => item.toJson())
                  .toList(),
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  ({PayPalAmountModel amount, PayPalItemsListModel payPalItemsListModel})
      getTransactionOrder() {
    Details details =
        Details(subtotal: "100", shipping: "0", shippingDiscount: 0);
    PayPalAmountModel amount =
        PayPalAmountModel(total: "100", currency: "USD", details: details);

    List<Item> items = [
      Item(name: "item 1", quantity: 1, price: "100", currency: "USD"),
    ];

    PayPalItemsListModel payPalItemsListModel =
        PayPalItemsListModel(items: items);
    return (amount: amount, payPalItemsListModel: payPalItemsListModel);
  }
}
