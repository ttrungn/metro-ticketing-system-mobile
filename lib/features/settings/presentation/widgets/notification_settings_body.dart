import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class NotificationSettingsBody extends StatefulWidget {
  const NotificationSettingsBody({super.key});

  @override
  _NotificationSettingsBodyState createState() =>
      _NotificationSettingsBodyState();
}

class _NotificationSettingsBodyState extends State<NotificationSettingsBody> {
  bool _isNotificationEnabled = true;

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
                title: Text('Tin tức'),
                subtitle: Text('Tin tức tiêu điểm'),
                trailing: Switch(
                  value: _isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _isNotificationEnabled = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Ứng dụng chưa được bật nhận thông báo'),
                trailing: TextButton(
                  onPressed: () {},
                  child: Text('Mở cài đặt'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
