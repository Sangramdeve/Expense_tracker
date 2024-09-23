
import 'package:hive/hive.dart';

part 'Transaction_data.g.dart';

@HiveType(typeId: 0)
class TransactionData {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String subtitle;
  @HiveField(3)
  final String amount;


  TransactionData({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'subtitle': subtitle,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'TransactionData{type: $type title: $title, subtitle: $subtitle, amount: $amount}';
  }
}
