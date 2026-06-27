class User {
  final String name;
  final String email;
  final String username;
  final double peso;
  final double altura;
  final String memberSince;
  final String plan;
  final int entrenos;
  final int completitud;
  final bool isAdult;

  const User({
    required this.name,
    required this.email,
    required this.username,
    required this.peso,
    required this.altura,
    required this.memberSince,
    required this.plan,
    required this.entrenos,
    required this.completitud,
    required this.isAdult,
  });

  User copyWith({
    String? name,
    String? email,
    String? username,
    double? peso,
    double? altura,
    bool? isAdult,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      peso: peso ?? this.peso,
      altura: altura ?? this.altura,
      memberSince: memberSince,
      plan: plan,
      entrenos: entrenos,
      completitud: completitud,
      isAdult: isAdult ?? this.isAdult,
    );
  }
}
