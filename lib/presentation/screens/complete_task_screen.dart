import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/empty_list_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_app_bar.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getAllCompleteTaskList();
  }

  bool _getCompletedTaskListInProgress = false;
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: backgroundwidget(
        child: Visibility(
          visible: _getCompletedTaskListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          //TODO: make it refresh indicator workable
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllCompleteTaskList();
            },
            child: Visibility(
              visible: _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const emptyListWidget(),
              child: ListView.builder(
                itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _completedTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllCompleteTaskList();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCompleteTaskList() async {
    _getCompletedTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSucces) {
      _completedTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getCompletedTaskListInProgress = false;
      setState(() {});
    } else {
      _getCompletedTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Get new taks has been failed',
        );
      }
    }
  }
}
