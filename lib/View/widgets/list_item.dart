import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final Color color;
  final String itemName;
  const ListItem({super.key,
    required this.color,
    required this.itemName
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      child: Row(
        children: [
          Icon(Icons.circle,color: color,size: 10,),
          SizedBox(width: 10,),
          Text(itemName,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15),)
        ],
      ),
    );
  }
}
