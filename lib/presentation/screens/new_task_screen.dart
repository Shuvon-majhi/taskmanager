import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/count_by_status_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/screens/add_new_task_screen.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';
import 'package:taskmanager/presentation/widgets/background_widget.dart';
import 'package:taskmanager/presentation/widgets/new_task_counter.dart';
import 'package:taskmanager/presentation/widgets/profile_app_bar.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';
import 'package:taskmanager/presentation/widgets/task_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskCountByStatusInProgress = false;
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();

  @override
  void initState() {
    super.initState();
    _getAllTaskCountByStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: backgroundwidget(
        child: Column(
          children: [
            Visibility(
                visible: _getAllTaskCountByStatusInProgress == false,
                replacement: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
                child: taskCounterSection),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        backgroundColor: AppColors.themecolor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: _countByStatusWrapper.listOfTaskByStatusData?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: _countByStatusWrapper.listOfTaskByStatusData![index].sId ??
                  '',
              amount:
                  _countByStatusWrapper.listOfTaskByStatusData![index].sum ?? 0,
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

  Future<void> _getAllTaskCountByStatus() async {
    _getAllTaskCountByStatusInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);
    if (response.isSucces) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'Get task count by status has been failed',
        );
      }
    }
  }
}
