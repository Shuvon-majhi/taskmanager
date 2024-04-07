import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/empty_list_widget.dart';
import 'package:taskmanager/presentation/widgets/profile_app_bar.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: backgroundwidget(
        child: Visibility(
          visible: _getCancelledTaskListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllcancelledTaskList();
            },
            child: Visibility(
              visible: _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const emptyListWidget(),
              child: ListView.builder(
                itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _cancelledTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllcancelledTaskList();
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

  Future<void> _getAllcancelledTaskList() async {
    _getCancelledTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);
    if (response.isSucces) {
      _cancelledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getCancelledTaskListInProgress = false;
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
