import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';

import '../../../widgets/TaskListTile.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../../data/services/ApiUrl.dart';
import '../UpdateTaskSheet.dart';
import '../UpdateTaskStatusSheet.dart';

class CompletedNavScreen extends StatefulWidget {
  const CompletedNavScreen({super.key});

  @override
  State<CompletedNavScreen> createState() => _CompletedNavScreenState();
}

class _CompletedNavScreenState extends State<CompletedNavScreen>{
  @override
  void initState() {
    super.initState();
    getCompletedTasks();
  }
  bool _getTaskCompletedInProgress = false;

  TaskListModel _taskListModel = TaskListModel();

  Future<void> getCompletedTasks() async {
    _getTaskCompletedInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetWorkCaller().getRequest(ApiUrl.completed);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getTaskCompletedInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> deleteTask(String taskId) async {
    final NetworkResponse response =
    await NetWorkCaller().getRequest(ApiUrl.deleteTask(taskId));
    if (response.isSuccess) {
      _taskListModel.data!.removeWhere((element) => element.sId == taskId);
      if (mounted) {
        setState(() {});
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Deletion of task has been failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            getCompletedTasks();
          },
          child: _getTaskCompletedInProgress
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : ListView.separated(
            itemCount: _taskListModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TaskListTile(
                data: _taskListModel.data![index],
                onDeleteTap: () {
                  deleteTask(_taskListModel.data![index].sId!);
                },
                onEditTap: () {
                  // showEditBottomSheet(_taskListModel.data![index]);
                  showStatusUpdateBottomSheet(
                      _taskListModel.data![index]);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 5,
              );
            },
          ),
        ),
      ),
    );
  }

  void showEditBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskSheet(
          task: task,
          onUpdate: () {
            getCompletedTasks();
          },
        );
      },
    );
  }

  void showStatusUpdateBottomSheet(TaskData task) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return UpdateTaskStatusSheet(
            task: task,
            onUpdate: () {
              getCompletedTasks();
            });
      },
    );
  }
}