import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/bottom_nav_screens/canceled_nav_screen.dart';
import 'package:task_manager/ui/screens/bottom_nav_screens/completed_nav_screen.dart';
import 'package:task_manager/ui/screens/bottom_nav_screens/in_progress_nav_screen.dart';
import 'package:task_manager/ui/screens/bottom_nav_screens/new_task_nav_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
    int _selectedScreenIndex=0;
final List<Widget> _screens=const[
  NewTaskNavScreen(),
  InProgressNavScreen(),
  CanceledNavScreen(),
  CompletedNavScreen()
];
  @override
  Widget build(BuildContext context) {
    // onTap(index){
    //   int currentIndex=0;
    //   if (currentIndex==index){
    //     setState(() {
    //     });
    //   }
    // }
    return Scaffold(
      body: _screens[_selectedScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: (int index){
              _selectedScreenIndex=index;
              if(mounted){
                setState(() {
                });
              }
        },


        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey
        ),
        selectedItemColor: Colors.green,
        showSelectedLabels: true,
         items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add),label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.incomplete_circle_outlined),label: "In progress"),
          BottomNavigationBarItem(icon: Icon(Icons.cancel),label: "Cancel"),
          BottomNavigationBarItem(icon: Icon(Icons.done_all),label: "completed"),
        ],


      ),
    );
  }
}
