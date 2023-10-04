import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final int number;
  final String title;
  const SummaryCard({
    super.key, required this.number, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        child: Column(
          children: [
          Text('$number',style: const TextStyle(
                  fontSize: 18,fontWeight: FontWeight.bold
              ),),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(title,style: const TextStyle(
                    fontSize: 16,
                ),),
            )
          ],
        ),
      ),
    );
  }
}