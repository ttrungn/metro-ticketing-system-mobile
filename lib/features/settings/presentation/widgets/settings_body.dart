import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/common/presentation/screens/error_screen.dart';
import '../../presentation/screens/access_permissions_screen.dart';
import '../../presentation/screens/notification_settings_screen.dart';
import '../../../../core/constants/app_color.dart';

class SettingsBody extends StatelessWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 23),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ConstantAppColor.primaryLight,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.notification_add_outlined, color: ConstantAppColor.primary),
                title: Text('Thông Báo', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: ConstantAppColor.primary),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.lock, color: ConstantAppColor.primary),
                title: Text('Quyền truy cập', style: TextStyle(fontSize: 20)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccessPermissionsScreen()),
                  );
                },
                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: ConstantAppColor.primary),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.language, color: ConstantAppColor.primary),
                title: Text('Ngôn ngữ', style: TextStyle(fontSize: 20)),
                subtitle: Text('Tiếng Việt', style: TextStyle(fontSize: 17, color: ConstantAppColor.primary)),
                onTap: () {
                  // Handle onTap action
                },
                trailing: Icon(Icons.arrow_forward_ios, size: 18, color: ConstantAppColor.primary),
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.info, color: ConstantAppColor.primary),
                title: Text('Phiên bản ứng dụng', style: TextStyle(fontSize: 20)),
                subtitle: Text('0.0.12', style: TextStyle(fontSize: 17, color: ConstantAppColor.primary)),
                onTap: () {
                  // Handle onTap action
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
