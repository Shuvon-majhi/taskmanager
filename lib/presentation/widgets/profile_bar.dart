import 'package:flutter/material.dart';
import 'package:taskmanager/presentation/utils/app_colors.dart';

PreferredSizeWidget get profileAppBar{
    return AppBar(
      backgroundColor: AppColors.themecolor,
      title: Row(
        children: [
          const CircleAvatar(),
          const SizedBox(
            width: 12,
          ),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shuvon Majhi',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'abcd@gmail.com',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
