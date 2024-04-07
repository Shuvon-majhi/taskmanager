import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/empty_list_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_app_bar.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: backgroundwidget(
        child: Visibility(
          visible: _getProgressTaskListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const emptyListWidget(),
              child: ListView.builder(
                itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _progressTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllProgressTaskList();
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

  Future<void> _getAllProgressTaskList() async {
    _getProgressTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSucces) {
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getProgressTaskListInProgress = false;
      setState(() {});
    } else {
      _getProgressTaskListInProgress = false;
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
