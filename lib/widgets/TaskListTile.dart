import 'package:flutter/material.dart';

import '../ui/data/models/task_list_model.dart';

class TaskListTile extends StatelessWidget {
  final VoidCallback onDeleteTap, onEditTap;

  const TaskListTile({
    super.key,
    required this.data,
    required this.onDeleteTap,
    required this.onEditTap,
  });

  final TaskData data;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text("Title: ${data.title ?? 'Unknown'}"),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Description: ${data.description ?? ''}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Date: ${data.createdDate ?? ''}"),
          ),
          Row(
            children: [
              Chip(

                label: Text(
                  data.status ?? 'New',
                  style: const TextStyle(color: Colors.white,),
                ),
                backgroundColor: Colors.blue,
              ),
              const Spacer(),
              IconButton(
                  onPressed: onDeleteTap,
                  icon: Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.red.shade300,
                  )),
              IconButton(
                  onPressed: onEditTap,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.green,
                  )),
            ],
          )
        ],
      ),
    );
  }
}