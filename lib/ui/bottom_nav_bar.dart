import 'package:flutter/material.dart';
import 'package:iternship/main.dart';
import 'package:iternship/screens/internships_cards.dart';

bool change = true;

class BottomBar extends StatelessWidget{
  final ValueChanged<bool> update;
  BottomBar({this.update});

  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.white,
      currentIndex: 0,
      onTap: (_selectedIndex) {
        switch (_selectedIndex) {
          case 0:
            update(change);
            break;
          case 1:
            Navigator.pushNamed(context, AppliedRoute);
            break;
        }
      },
      iconSize: 30.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.filter_alt),
          label: 'Filter',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.approval),
          label: 'Applied',
          backgroundColor: Colors.white,
        ),

      ],
    );
  }

  _onAppliedTap(BuildContext context) {
    Navigator.pushNamed(context, AppliedRoute);
  }
}


