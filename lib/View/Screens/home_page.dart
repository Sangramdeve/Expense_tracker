import '../../app_imports.dart';
import '../../cores/services/hive_services.dart';
import '../widgets/bottom_sheet.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<int> item = [12, 35, 69, 35, 90, 45, 78, 45];
  late Future<List<TransactionData>> transactionData;
  HiveServices hiveServices = HiveServices();

  @override
  Widget build(BuildContext context) {
    debugPrint('object in build');
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        actions: [
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return const BottomSheetWidget();
                },
              );
            },
            icon: const Icon(Icons.add_circle_outline),
            label: const Text('Add Expense'),
          )
        ],
        leading: Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu));
        }),
        title: const ListTile(
          title: Text(
            "2000.00",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            "Total spend",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 48.0),
            child: FittedBox(child: MasterCard()),
          ),
        ],
      )),
      body: SafeArea(
          minimum:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //buildExpanded(),
              const MasterCard(),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Monthly Expenses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              const MonthlyExpense(),
              const Row(
                children: [
                  Text(
                    'Transactions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Spacer(),
                  Text('See All',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.brown)),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
              FutureBuilder<Box<TransactionData>>(
                future: hiveServices.openBox(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error opening box'));
                    } else {
                      return ValueListenableBuilder(
                        valueListenable: hiveServices.getExpenseListenable(),
                        builder: (context, Box<TransactionData> box, _) {
                          final transactions = box.values.toList().cast<
                              TransactionData>(); // Make sure it casts correctly

                          return Flexible(
                            child: Consumer<ManegeAppState>(
                              builder: (context, snapshot, _) {
                                return ListView.builder(
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: Key(transactions[index].toString()),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        color: Colors.red,
                                        // Background color when swiping
                                        alignment: Alignment.centerRight,
                                        // Align the delete icon to the right
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: const Icon(Icons.delete,
                                            color: Colors.white), // Delete icon
                                      ),
                                      onDismissed: (direction) {
                                        snapshot.deleteItem(index);
                                        SnackBarHelper.showCustomMessage(
                                            context,
                                            'Deleted successfully',
                                            Colors.red);
                                      },
                                      child: ListTile(
                                        leading:
                                            _getIcon(transactions[index].title),
                                        title: Text(
                                          transactions[index].title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Opacity(
                                            opacity: 0.5,
                                            child: Text(
                                                transactions[index].subtitle)),
                                        trailing: Text(
                                          transactions[index].amount.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 15),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              )
            ],
          )),
    );
  }

  Expanded buildExpanded() {
    return Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      return Days(
                        index: index,
                        percent: item[index],
                      );
                    }));
  }

  Icon _getIcon(String title) {
    switch (title) {
      case 'Groceries':
        return const Icon(Icons.shopping_cart);
      case 'Dining Out':
        return const Icon(Icons.restaurant);
      case 'Gas':
        return const Icon(Icons.local_gas_station);
      case 'Recharge':
        return const Icon(Icons.phone_android);
      case 'Money Transfer':
        return const Icon(
          Icons.money,
        );
      default:
        return const Icon(Icons.category, color: Colors.grey);
    }
  }
}

class Days extends StatelessWidget {
  const Days({
    super.key,
    required this.index,
    required this.percent,
  });

  final int index;
  final int percent;

  @override
  Widget build(BuildContext context) {
    const maxHeight = 150;
    final bool isToday = index == DateTime.now().weekday - 1; // Highlight today

    return SizedBox(
      width: 60, // Slightly wider for better spacing
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Percentage Text
          Text(
            '$percent%',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 10),
          // Bar Container
          SizedBox(
            height: maxHeight.toDouble(),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 30,
                height: (percent / 100) * maxHeight,
                // Bar height relative to percentage
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // Shadow effect
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Opacity(
            opacity: 0.2,
            child: Divider(
              color: Colors.black,
              height: 10,
              thickness: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Day ${index + 1}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              // Highlight today
              color: isToday ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
