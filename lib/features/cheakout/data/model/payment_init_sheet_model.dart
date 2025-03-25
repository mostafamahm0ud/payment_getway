class PaymentInitSheetModel {
  final String paymentIntentClientSecret;
  final String ephemeralKeySecret;
  final String customerId;

  PaymentInitSheetModel(
      {required this.paymentIntentClientSecret,
      required this.ephemeralKeySecret,
      required this.customerId});
}
