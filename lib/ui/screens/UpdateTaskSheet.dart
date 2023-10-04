import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';

import '../data/models/network_response.dart';
import '../data/models/task_list_model.dart';


class UpdateTaskSheet extends StatefulWidget {
  final TaskData task;
  final VoidCallback onUpdate;

  const UpdateTaskSheet(
      {super.key, required this.task, required this.onUpdate});

  @override
  State<UpdateTaskSheet> createState() => _UpdateTaskSheetState();
}

class _UpdateTaskSheetState extends State<UpdateTaskSheet> {
  late TextEditingController _titleTEController;

  late TextEditingController _descriptionTEController;

  bool _updateTaskInProgress = false;

  @override
  void initState() {
    _titleTEController = TextEditingController(text: widget.task.title);
    _descriptionTEController =
        TextEditingController(text: widget.task.description);
    super.initState();
  }

  Future<void> updateTask() async {
    _updateTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestBody = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
    };
    final NetworkResponse response =
    await NetWorkCaller().postRequest(ApiUrl.createTask, requestBody);
    _updateTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _titleTEController.clear();
      _descriptionTEController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Task updated successfully')));
      }
      widget.onUpdate();
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Task update failed!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Update task',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(hintText: 'Title'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Description',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: Visibility(
                  visible: _updateTaskInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        updateTask();
                      },
                      child: const Text('Update Task')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}