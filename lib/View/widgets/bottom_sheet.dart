

import '../../app_imports.dart';
import '../../cores/services/firebase_services.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  HiveCrud hiveCrud = HiveCrud();
  FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.75,
        child: SizedBox(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DropDownMenuButton(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Consumer<ManegeAppState>(
                builder: (context,manegeAppState,_){
                  return Text(
                    '\$${manegeAppState.input}',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text('Add comment...', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),
              Consumer<ManegeAppState>(
                builder: (context,manegeAppState,_){
                  return  Flexible(
                    child: GridView.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.2,
                      children: [
                        buildButton("1", Colors.grey[200]!),
                        buildButton("2", Colors.grey[200]!),
                        buildButton("3", Colors.grey[200]!),
                        buildIconButton(Icons.import_contacts, Colors.transparent,false),
                        buildButton("4", Colors.grey[200]!),
                        buildButton("5", Colors.grey[200]!),
                        buildButton("6", Colors.grey[200]!),
                        GestureDetector(
                          onTap:(){
                          },
                          child: buildIconButton(
                              Icons.calendar_today, Colors.blue[100]!,true),
                        ),
                        buildButton("7", Colors.grey[200]!),
                        buildButton("8", Colors.grey[200]!),
                        buildButton("9", Colors.grey[200]!),
                        GestureDetector(
                            onTap: manegeAppState.onClearButton,
                            child: buildIconButton(Icons.backspace, Colors.red[100]!,true)),
                        // Empty space
                        buildButton("\$", Colors.yellow[100]!),
                        buildButton("0", Colors.grey[200]!),
                        buildButton(".", Colors.grey[200]!),
                        GestureDetector(
                          onTap: () {
                            _firestoreService.addDocument(collectionPath: 'Expense', data: manegeAppState.transactionData);
                            hiveCrud.addNewTransaction(manegeAppState.transactionData);
                            Navigator.of(context).pop();
                            SnackBarHelper.showSuccessMessage(context, 'Expense created successfully!');
                          },
                            child: buildIconButton(Icons.check, Colors.green,true)),
                      ],
                    ),
                  );
                },
              ),

            ],
          ),
        ));
  }

  Widget buildButton(String label, Color color) {
    final state = Provider.of<ManegeAppState>(context,listen: false);
    return GestureDetector(
      onTap: () => state.onButtonClick(label),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget buildIconButton(IconData icon, Color color,bool value) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: value ? Icon(
          icon,
          size: 30,
          color: Colors.black,
        ):  null,
      ),
    );
  }

}
