import 'package:flutter/material.dart';
import 'package:taskmanager/data/models/task_item.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/widgets/snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
    required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateStatusInProgress = false;
  bool _deleteTaskInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.taskItem.description ?? ''),
            Text('Date: ${widget.taskItem.createdDate}'),
            Row(
              children: [
                Chip(
                  label: Text(widget.taskItem.status ?? ''),
                ),
                const Spacer(),
                Visibility(
                  visible: _updateStatusInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _showUpdateStatusDialog(widget.taskItem.sId!);
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                    onPressed: () {
                      _deleteTaskById(widget.taskItem.sId!);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New'),
                trailing:
                    _isCurrentStatus('New') ? const Icon(Icons.check) : null,
                onTap: () {
                  if (_isCurrentStatus('New')) {
                    return;
                  }
                  _isCurrentStatus('New');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Completed'),
                trailing: _isCurrentStatus('Completed')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Completed')) {
                    return;
                  }
                  _isCurrentStatus('Completed');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Progress'),
                trailing: _isCurrentStatus('Progress')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Progress')) {
                    return;
                  }
                  _isCurrentStatus('Progress');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Cancelled'),
                trailing: _isCurrentStatus('Cancelled')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Cancelled')) {
                    return;
                  }
                  _isCurrentStatus('Cancelled');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;
    if (response.isSucces) {
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
          context,
          response.errorMessage ?? 'delete taks has been failed',
        );
      }
    }
  }

  bool _isCurrentStatus(String status) {
    return widget.taskItem.status! == status;
  }
}
