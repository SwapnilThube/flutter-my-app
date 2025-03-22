class ProfileModel {
  int id;
  String name;
  String status;
  bool select = false;
  ProfileModel({
    required this.id,
    required this.name,
    required this.status,
    this.select = false,
  });
}
