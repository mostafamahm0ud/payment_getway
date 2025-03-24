import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_getway/core/utils/api_keys.dart';
import 'package:payment_getway/core/utils/api_services.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_input_model.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_model/payment_intent_model.dart';

class StripServices {
  ApiServices apiServices = ApiServices();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiServices.postRequest(
      url: 'https://api.stripe.com/v1/payment_intents',
      body: paymentIntentInputModel.toJson(),
      token: ApiKeys.secreteKey,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initiatePaymentSheet(
      {required String paymentIntentClientSecret}) async {
    try {
      Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Payment Getway',
        ),
      );
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    await initiatePaymentSheet(
        paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await presentPaymentSheet();
  }
}
