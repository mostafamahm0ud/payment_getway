import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_getway/features/cheakout/data/model/payment_intent_input_model.dart';
import 'package:payment_getway/features/cheakout/data/repo/checkout_repo.dart';

part 'strip_payment_cubit_state.dart';

class StripPaymentCubitCubit extends Cubit<StripPaymentCubitState> {
  StripPaymentCubitCubit(this.checkoutRepo) : super(StripPaymentCubitInitial());

  final CheckoutRepo checkoutRepo;

  Future<void> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(StripPaymentCubitLoading());
    final data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold((l) => emit(StripPaymentCubitFailure(l.errmessage)),
        (r) => emit(StripPaymentCubitSuccess()));
  }

  @override
  void onChange(Change<StripPaymentCubitState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
