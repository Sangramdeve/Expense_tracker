import '../../app_imports.dart';

enum Type {
  groceries('Groceries'),
  diningOut('Dining Out'),
  gas('Gas'),
  recharge('Recharge'),
  transferTo('Money Transfer');

  const Type(
    this.label,
  );

  final String label;
}

class DropDownMenuButton extends StatefulWidget {
  const DropDownMenuButton({super.key});

  @override
  State<DropDownMenuButton> createState() => _DropDownMenuButtonState();
}

class _DropDownMenuButtonState extends State<DropDownMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ManegeAppState>(
      builder: (context, manegeAppState,_) {
        return DropdownMenu<Type>(
            initialSelection: Type.groceries,
            menuStyle: const MenuStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.white),
              elevation: WidgetStatePropertyAll(8), // Shadow effect
              shape: null
            ),
            dropdownMenuEntries:
                Type.values.map<DropdownMenuEntry<Type>>((Type type) {
              return DropdownMenuEntry<Type>(
                  value: type,
                  label: type.label,
                  //enabled: Colors.black != 'Grey',
                  style: MenuItemButton.styleFrom(
                    foregroundColor: Colors.black,
                  ));
            }).toList(),
            onSelected: (Type? newValue) {
              manegeAppState.setDropDownValue(newValue!.label);
            }
        );
      }
    );
  }
}
