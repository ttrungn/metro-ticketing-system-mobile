class ProfileInfo {
  final String name;
  final String email;
  final String isStudent;

  ProfileInfo({
    required this.name,
    required this.email,
    required this.isStudent,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> data) {
    return ProfileInfo(
      name: data['name']['firstName'] + ' ' + data['name']['lastName'],
      email: data['email'],
      isStudent: data['isStudent'] ? 'Đã xác nhận' : 'Chưa xác nhận',
    );
  }
}