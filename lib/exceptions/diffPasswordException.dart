class DiffPasswordException implements Exception{
  final String msg;
  const DiffPasswordException(this.msg);
  String toString() => msg;
}