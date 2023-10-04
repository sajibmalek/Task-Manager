import 'package:flutter/material.dart';
import 'package:task_manager/ui/data/models/network_response.dart';
import 'package:task_manager/ui/data/services/ApiUrl.dart';
import 'package:task_manager/ui/data/services/network_caller.dart';
import 'package:task_manager/ui/screens/sign_up_screen.dart';
import 'package:task_manager/ui/utility/assets_utility/assets_utility.dart';

import '../../widgets/reusable_background.dart';
import '../utility/assets_utility/string_utility.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}



class _AddNewTaskState extends State<AddNewTask> {
  bool _isnewTaksProgress=false;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addNewTaskForm = GlobalKey<FormState>();

  Future<void> addNewTask() async{
    _isnewTaksProgress=true;
    if(mounted){setState((){
    });}
    final NetworkResponse response=await NetWorkCaller().postRequest(ApiUrl.createTask, <String,dynamic>{
      "title":_titleController.text.trim(),
      "description":_descriptionController.text.trim(),
      "status":"New"
    }) ;
    if(response.isSuccess){
      //_isnewTaksProgress=false;
      _titleController.clear();
      _descriptionController.clear();
    }
    _isnewTaksProgress=false;
    if(mounted){setState((){
    });}
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          const Expanded(flex: 1, child: AppBackGround()),
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _addNewTaskForm,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30, right: 40, top: 170, bottom: 12),
                      child: const Text(
                        AppString.add_new_task,
                        style:
                            TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: 310,
                      margin:
                          const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return AppString.enter_title;
                          }

                          if (mounted) {
                            setState(() {});
                          }
                          return null;
                        },
                        controller: _titleController,
                        decoration: InputDecoration(
                            //contentPadding:EdgeInsets.only(),
                            // hintText: "exmaple@gmail.com",
                            label: const Text(AppString.title),
                            prefixIconColor: Colors.green,
                            //prefixText: "*******",
                            hintText: "Class test",
                            prefixIcon: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.title,
                                  size: 20,
                                )),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.green,
                                ),
                                borderRadius: BorderRadius.circular(5))),
                      ),
                    ),
                    Container(
                      width: 310,
                      margin:
                      const EdgeInsets.only(left: 64, right: 35, bottom: 15),
                      child: TextFormField(
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return AppString.enter_description;
                          }

                          if (mounted) {
                            setState(() {});
                          }
                          return null;
                        },
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                           contentPadding:EdgeInsets.only(bottom: 100),
                          // hintText: "exmaple@gmail.com",
                            label: Text(AppString.description),
                            prefixIconColor: Colors.green,
                            //prefixText: "*******",
                            hintText: "description",
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.description,
                                  size: 20,
                                )),
                       ),
                      ),
                    ),

                    Visibility(
                      visible: _isnewTaksProgress==false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: InkWell(
                        splashColor: Colors.indigo,
                        onTap: () {
                          if (!_addNewTaskForm.currentState!.validate()) {
                            return;
                          }
                          addNewTask();
                          if(mounted){
                            Navigator.pop(context);
                          }

                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 68, right: 40),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5)),
                          width: 310,
                          height: 40,
                          child: const Center(
                            child: Icon(
                              Icons.navigate_next_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                     Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                     // mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12, right: 5),
                          child: Text(
                            AppString.dont_account,
                            style: TextStyle(
                                fontSize: 11, fontWeight: FontWeight.normal),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12, right: 1),
                          child: TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (c)=>const SignUpScreen()));
                          }, child: const Text(AppString.signUp,style: TextStyle(color: Colors.green),))
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
          //top text container
          //sub text container
        ],
      ),
    );
  }
}
