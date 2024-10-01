import 'package:aldi_test/helper/global_var.dart';
import 'package:aldi_test/theme/theme.dart';
import 'package:aldi_test/view/dashboard/dashboard.controller.dart';
import 'package:aldi_test/widget/app_square_initial.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppTheme.padding),
              header(),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppTheme.padding,
        right: 2,
      ),
      child: Row(
        children: [
          AppSquareInitial(initial: user!.initial),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Datang ${user!.username}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  user!.email,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.capColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
