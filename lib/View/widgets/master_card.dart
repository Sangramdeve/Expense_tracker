import 'package:expance_traker/cores/const/color_const.dart';
import 'package:flutter/material.dart';



class MasterCard extends StatefulWidget {
  const MasterCard({super.key});

  @override
  State<MasterCard> createState() => _MasterCardState();
}

class _MasterCardState extends State<MasterCard> {
  bool _isHidden = true;

  final String _cardNumber = '4355 8701 1092 8705';

  String get _displayCardNumber {
    if (_isHidden) {
      return _cardNumber.replaceRange(0, _cardNumber.length - 4, '**** **** **** ');
    }
    return _cardNumber;
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 10,),
      child: Container(
          height: 220,
          width: 400,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: customColor.withOpacity(0.7),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.9), // Light shadow for top-left
                  offset: const Offset(-6, -6),
                  blurRadius: 16,
                ),
                const BoxShadow(
                  color: shadowColor,
                  offset: Offset(7, 7),
                  blurRadius: 26,
                ),
              ]
          ),
          child: Stack(
            children: [
              //bottom  circle
              Positioned(
                bottom: -200,
                right: -20,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              //right side circle
              Positioned(
                top: -90,
                right: 140,
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                ),),
              Positioned(
                top: -140,
                right: -100,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.9),
                        width: 1.5,
                        style: BorderStyle.solid,
                      )
                  ),
                ),),
              Positioned(
                top: 20,
                left: 20,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 45,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const Positioned(
                  top: 25,
                  left: 95,
                  child: Text('mastercard',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),)
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(_displayCardNumber,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: _toggleVisibility,
                          child: Opacity(
                              opacity: 0.4,
                              child: Text(_isHidden ? 'Show' : 'Hide',style: const TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    const Text('PLATINUM CARD',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
