import 'package:exchange/features/presentation/dashboard/dashboard_getx.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final DashboardGetx getx = Get.put(DashboardGetx());

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      body: Obx(() => getx.page[getx.index.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: getx.index.value,
          backgroundColor: theme.scaffoldBackgroundColor,
          onTap: getx.onChanged,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: theme.primaryColor),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: theme.primaryColor),
              label: 'Setting',
            ),
          ],
          selectedItemColor: theme.primaryColor,
          selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 10, color: theme.primaryColor),
        ),
      ),
    );
  }
}
