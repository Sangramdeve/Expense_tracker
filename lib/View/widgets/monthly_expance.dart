import 'package:expance_traker/cores/const/color_const.dart';

import '../../../app_imports.dart';

class MonthlyExpense extends StatelessWidget {
  const MonthlyExpense({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15,bottom:10),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListItem(color: deepPurple, itemName: 'Groceries',),
              ListItem(color: blueAccent, itemName: 'Online Shopping',),
              ListItem(color: green, itemName: 'Eating Out',),
              ListItem(color: amber, itemName: 'Bills',),
              ListItem(color: red, itemName: 'Subscriptions',),
              ListItem(color: blueGrey, itemName: 'Fees',),
            ],
          ),
          const Spacer(),
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(-9, -9),
                    blurRadius: 15,
                    color: Colors.white.withOpacity(.5),
                  ),
                  const BoxShadow(
                    offset: Offset(9, 9),
                    blurRadius: 15,
                    color: Colors.black12,
                  )
                ]
            ),
            child: CustomPaint(
              size: const Size(60, 60),
              painter: ChartCircle(
                  percent: [56,16,11,8,6,3], outerRadius: 40,
                  innerRadius: 10,
                  color: [blueAccent,deepPurple,green,amber,red,blueGrey]
              ),
              child:  Center(
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: bgColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(-9, -9),
                          blurRadius: 15,
                          color: Colors.white12,
                        ),
                        BoxShadow(
                          offset: Offset(5, 5),
                          blurRadius: 15,
                          color: Colors.black12,
                        )
                      ]
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}