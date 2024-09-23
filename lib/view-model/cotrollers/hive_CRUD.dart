import 'package:expance_traker/app_imports.dart';
import 'package:expance_traker/cores/services/hive_services.dart';

class HiveCrud {
  HiveServices hiveServices = HiveServices();

  void addNewTransaction(TransactionData transactionData) async {
    try{
      await hiveServices.addExpense(transactionData);
      print('Transaction added successfully!');
    }catch(e){
      print('hive error: $e ');
    }
  }

}
