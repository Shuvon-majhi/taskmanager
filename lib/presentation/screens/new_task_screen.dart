import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/data/models/task_Count_by_status_data.dart';
import 'package:taskmanager/presentation/controller/count_task_by_controller.dart';
import 'package:taskmanager/presentation/controller/new_task_controller.dart';
import 'package:taskmanager/presentation/screens/add_new_task_screen.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/empty_list_widget.dart';
import 'package:taskmanager/presentation/widgets/new_task_counter.dart';
import 'package:taskmanager/presentation/widgets/profile_app_bar.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {

  @override
  void initState() {
    super.initState();
    _getDatafromApis();
  }

  void _getDatafromApis() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: backgroundwidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
                builder: (countTaskByStatusController) {
              return Visibility(
                visible: countTaskByStatusController.inProgress == false,
                replacement: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                child: taskCounterSection(countTaskByStatusController
                        .countByStatusWrapper.listOfTaskByStatusData ??
                    []),
              );
            }),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        _getDatafromApis();
                      },
                      child: Visibility(
                        visible: newTaskController.newTaskListWrapper.taskList?.isNotEmpty ?? false,
                        replacement: const emptyListWidget(),
                        child: ListView.builder(
                          itemCount: newTaskController.newTaskListWrapper.taskList?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              taskItem: newTaskController.newTaskListWrapper.taskList![index],
                              refreshList: () {
                                _getDatafromApis();
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //TODO: recall the home apis
          final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
          if (result == true) {
            _getDatafromApis();
          }
        },
        backgroundColor: AppColors.themecolor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget taskCounterSection(
      List<TaskCountByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCountByStatus.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: listOfTaskCountByStatus[index].sId ?? '',
              amount: listOfTaskCountByStatus[index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 10,
            );
          },
        ),
      ),
    );
  }
}
