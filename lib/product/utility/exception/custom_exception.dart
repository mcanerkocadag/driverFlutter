class FirebaseCustomException implements Exception {
  FirebaseCustomException(this.description);

  final String description;

  @override
  String toString() {
    // TODO: implement toString
    return '$this $description';
  }
}

class VersionException implements Exception {
  VersionException(this.description);

  final String description;

  @override
  String toString() {
    // TODO: implement toString
    return '$this $description';
  }
}
