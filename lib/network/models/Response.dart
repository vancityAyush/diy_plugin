class ResponseModel {
  final bool success;
  final dynamic message;

  ResponseModel({required this.success, this.message});

  @override
  String toString() {
    return message.toString();
  }
}
