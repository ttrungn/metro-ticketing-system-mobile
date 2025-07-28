import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class AccessPermissionsBody extends StatefulWidget {
  const AccessPermissionsBody({super.key});

  @override
  _AccessPermissionsBodyState createState() => _AccessPermissionsBodyState();
}

class _AccessPermissionsBodyState extends State<AccessPermissionsBody> {
  bool _isCameraEnabled = true;
  bool _islocationEnabled = true;
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
                title: Text('Camera'),
                subtitle: Text(
                  'Ung dụng cần quyền truy cập camera để chụp ảnh gửi phản ánh, vui lòng cấp quyền cho ứng dụng',
                ),
                trailing: Switch(
                  value: _isCameraEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _isCameraEnabled = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text('Vị trí'),
                subtitle: Text(
                  'Ứng dụng cần quyền truy cập vị trí của điện thoại để lấy dữ liệu thời tiết, bản đồ chính xác hơn. vui lòng cấp quyền cho ứng dụng',
                ),
                trailing: Switch(
                  value: _islocationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _islocationEnabled = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
