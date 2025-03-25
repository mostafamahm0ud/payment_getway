import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_getway/core/utils/api_keys.dart';
import 'package:payment_getway/core/utils/api_services.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_customer_model/payment_customer_model.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_ephemral_key_model/payment_ephemral_key_model.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_init_sheet_model.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_input_model.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_model/payment_intent_model.dart';

class StripServices {
  ApiServices apiServices = ApiServices();
  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    var response = await apiServices.postRequest(
      url: 'https://api.stripe.com/v1/payment_intents',
      contentType: Headers.formUrlEncodedContentType,
      body: paymentIntentInputModel.toJson(),
      token: PaymentApiKeys.secreteKey,
    );

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<PaymentEphemralKeyModel> getEphemralKey(String customerId) async {
    var response = await apiServices.postRequest(
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      contentType: Headers.formUrlEncodedContentType,
      body: {
        'customer': customerId,
      },
      headers: {
        'Authorization': 'Bearer ${PaymentApiKeys.secreteKey}',
        'Stripe-Version': '2025-02-24.acacia'
      },
      token: PaymentApiKeys.secreteKey,
    );

    var paymentEphemralKeyModel =
        PaymentEphemralKeyModel.fromJson(response.data);
    return paymentEphemralKeyModel;
  }

  Future<PaymentCustomerModel> createCustomer(String name) async {
    var response = await apiServices.postRequest(
      url: 'https://api.stripe.com/v1/customers',
      contentType: Headers.formUrlEncodedContentType,
      body: {
        'name': name,
      },
      token: PaymentApiKeys.secreteKey,
    );

    var paymentCustomerModel = PaymentCustomerModel.fromJson(response.data);
    return paymentCustomerModel;
  }

  Future initiatePaymentSheet(
      {required PaymentInitSheetModel paymentIntentSheetModel}) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret:
              paymentIntentSheetModel.paymentIntentClientSecret,
          customerEphemeralKeySecret:
              paymentIntentSheetModel.ephemeralKeySecret,
          customerId: paymentIntentSheetModel.customerId,
          merchantDisplayName: 'Payment Getway',
        ),
      );
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      log('Error: ${e.toString()}');
    }
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    // var paymentCustomerModel = await createCustomer('Rahul');
    var paymentEphemralKeyModel = await getEphemralKey("cus_S0agI7o7rbXbHl");
    PaymentInitSheetModel paymentIntentSheetModel = PaymentInitSheetModel(
      paymentIntentClientSecret: paymentIntentModel.clientSecret!,
      ephemeralKeySecret: paymentEphemralKeyModel.secret!,
      customerId: "cus_S0agI7o7rbXbHl",
    );
    await initiatePaymentSheet(
      paymentIntentSheetModel: paymentIntentSheetModel,
    );
    await presentPaymentSheet();
  }
}
