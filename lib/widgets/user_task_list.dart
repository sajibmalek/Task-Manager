 import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/models/task_list_model.dart';

class UserTaskList extends StatelessWidget {

//final TaskData data;
TaskListModel taskListModel=TaskListModel();
TaskData? taskData;

  UserTaskList({super.key});
  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: taskListModel.data?.length??0,
        itemBuilder: (context, index) {

            ListTile(
              title:   Padding(
                padding: const EdgeInsets.all(4.0),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(taskData?.title??"Unknown"),
                ),
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(taskData?.description??""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(taskData?.createdDate??""),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                        Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Chip(
                          label: Text(
                           taskData?.status??"New",
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.edit_note, color: Colors.green),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.red.shade400,
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
            return null;
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 5,
          );
        },
      );

  }
}
