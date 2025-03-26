import 'item.dart';

class PayPalItemsListModel {
  final List<Item>? items;

  PayPalItemsListModel({required this.items});

  factory PayPalItemsListModel.fromJson(Map<String, dynamic> json) {
    return PayPalItemsListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
      };
}
