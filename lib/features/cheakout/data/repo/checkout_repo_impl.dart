import 'package:dartz/dartz.dart';
import 'package:payment_getway/core/errors/failures.dart';
import 'package:payment_getway/core/utils/strip_services.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_input_model.dart';
import 'package:payment_getway/features/cheakout/data/repo/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripServices stripServices = StripServices();
  @override
  Future<Either<Failures, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripServices.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServerFailures(errmessage: e.toString()));
    }
  }
}
