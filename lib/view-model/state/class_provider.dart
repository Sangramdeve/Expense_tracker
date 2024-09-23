import 'package:expance_traker/app_imports.dart';
import 'package:expance_traker/cores/services/hive_services.dart';
import 'package:intl/intl.dart';

class ManegeAppState with ChangeNotifier {
  HiveServices hiveServices = HiveServices();
  String _input = '0';
  String _dropDownValue = '';


  String get input => _input;

  String get dropDownValue => _dropDownValue;


  TransactionData get transactionData => TransactionData(
        type: 'cash',
        title: _dropDownValue,
        subtitle: getFormattedCurrentTimestamp(),
        amount: _input,
      );

  String getFormattedCurrentTimestamp() {
    final now = DateTime.now();
    return DateFormat('yMMMd, hh:mm a')
        .format(now);
  }

  void deleteItem(int index) {
    hiveServices.deleteExpense(index);
  }

  void setDropDownValue(String value) {
    _dropDownValue = value;
    notifyListeners();
  }

  void onButtonClick(String value) {
    if (input == '0') {
      _input = value;
    } else {
      _input += value;
    }
    notifyListeners();
  }

  void onClearButton() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, input.length - 1);
      notifyListeners();
    }
  }
}
