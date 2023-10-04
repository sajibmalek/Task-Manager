import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/add_new_task.dart';
import '../../../widgets/TaskListTile.dart';
import '../../../widgets/summary_card.dart';
import '../../../widgets/user_profile_banner.dart';
import '../../data/models/SummaryCountModel.dart';
import '../../data/models/network_response.dart';
import '../../data/models/task_list_model.dart';
import '../UpdateTaskSheet.dart';
import '../UpdateTaskStatusSheet.dart';


class NewTaskNavScreen extends StatefulWidget {
  const NewTaskNavScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskNavScreen> createState() => _NewTaskNavScreenState();
}

class _NewTaskNavScreenState extends State<NewTaskNavScreen> {
  bool _getCountSummaryInProgress = false, _getNewTaskInProgress = false;
  SummaryCountModel _summaryCountModel = SummaryCountModel();
  TaskListModel _taskListModel = TaskListModel();

  @override
  void initState() {
    super.initState();
    // after widget binding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCountSummary();
      getNewTasks();
    });
  }

  Future<void> getCountSummary() async {
    _getCountSummaryInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetWorkCaller().getRequest(ApiUrl.taskStatusCount);
    if (response.isSuccess) {
      _summaryCountModel = SummaryCountModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('get new task data failed')));
      }
    }
    _getCountSummaryInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> getNewTasks() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetWorkCaller().getRequest(ApiUrl.newTask);
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.body!);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Summary data get failed')));
      }
    }
    _getNewTaskInProgress = false;
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
        body: Column(
              children: [
                const UserProfileAppBar(),
                _getCountSummaryInProgress
                    ? const LinearProgressIndicator()
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _summaryCountModel.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        return SummaryCard(
                          title: _summaryCountModel.data![index].sId ?? 'New',
                          number: _summaryCountModel.data![index].sum ?? 0,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 4,
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      getNewTasks();
                      getCountSummary();
                    },
                    child: _getNewTaskInProgress
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
                            showStatusUpdateBottomSheet(_taskListModel.data![index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(
                          height: 4,
                        );
                      },
                    ),
                  ),
                ),
              ],
          ),


        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewTask()));
          },

      )
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
            getNewTasks();
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
        return UpdateTaskStatusSheet(task: task, onUpdate: () {
          getNewTasks();
        });
      },
    );
  }
}