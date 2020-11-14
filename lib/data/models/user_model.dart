
class User {
  int id;
  String name;
  String email;
  String city;
  String gender;
  double lat;
  double long;
  int points;
  String address;
  String mobile;
  String emailVerifiedAt;
  String image;

  User({
    this.id,
    this.name,
    this.email,
    this.city,
    this.gender,
    this.image,
    this.emailVerifiedAt,
    this.lat,
    this.long,
    this.mobile,
    this.points=0,
    this.address
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        //This will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a User object
        id:data['id'],
        name: data['name'],
        email: data['email'],
        emailVerifiedAt: data['email_verified_at'],
        image: data['image'].toString(),
        lat: double.tryParse(data['lat'].toString()),
        long: double.tryParse(data['long'].toString()),
        gender: data['gender'],
        city: data['city'],
        mobile:data['mobile'],
        points:int.tryParse(data['points'].toString()),
        address: data['address']
      );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'image': image,
    'email_verified_at':emailVerifiedAt
  };

  Map<String, dynamic> toUpdateJson() => {
    'name': name,
    'email': email,
  };
}
