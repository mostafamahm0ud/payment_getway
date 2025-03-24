import 'package:dartz/dartz.dart';
import 'package:payment_getway/core/errors/failures.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failures, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
