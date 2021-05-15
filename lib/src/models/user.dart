class User {
  final String age;
  final String email;
  final String name;
  final String school;
  final String userId;
  final String target;
  final String twitter;
  final String lastName;
  final String newEmail;
  final String facebook;
  final String instagram;
  final String profession;
  final String imageUrl;

  User({
    this.age,
    this.name,
    this.email,
    this.target,
    this.userId,
    this.imageUrl,
    this.school,
    this.twitter,
    this.lastName,
    this.newEmail,
    this.facebook,
    this.instagram,
    this.profession,
  });

  Map<String, dynamic> toMap([Map<String, String> map]) {
    return {
      'age': age,
      'name': name,
      'email': email,
      'target': target,
      'userId': userId,
      'school': school,
      'twitter': twitter,
      "imageUrl": imageUrl ??
          "https://www.erenyapidekorasyon.com.tr/wp-content/uploads/2018/11/D-10.jpg",
      'lastName': lastName,
      'facebook': facebook,
      'newEmail': newEmail,
      'instagram': instagram,
      'profession': profession,
    };
  }

  User.fromFirestore(Map<String, dynamic> firestore)
      : age = firestore['age'],
        name = firestore['name'],
        email = firestore['email'],
        target = firestore['target'],
        userId = firestore['userId'],
        imageUrl = firestore['imageUrl'],
        school = firestore['school'],
        twitter = firestore['twitter'],
        lastName = firestore['lastName'],
        facebook = firestore['facebook'],
        newEmail = firestore['newEmail'],
        instagram = firestore['instagram'],
        profession = firestore['profession'];
}
