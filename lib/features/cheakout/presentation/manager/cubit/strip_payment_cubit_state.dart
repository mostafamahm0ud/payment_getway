part of 'strip_payment_cubit_cubit.dart';

@immutable
sealed class StripPaymentCubitState {}

final class StripPaymentCubitInitial extends StripPaymentCubitState {}

final class StripPaymentCubitLoading extends StripPaymentCubitState {}

final class StripPaymentCubitSuccess extends StripPaymentCubitState {}

final class StripPaymentCubitFailure extends StripPaymentCubitState {
  final String message;
  StripPaymentCubitFailure(this.message);
}
