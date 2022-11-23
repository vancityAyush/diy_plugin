class ResponseModel {
  final bool status;
  final dynamic arguments;
  final String message;

  ResponseModel({required this.status, this.arguments, this.message = ""});

  ResponseModel.False({this.arguments, this.message = ""}) : status = false;

  @override
  String toString() {
    return arguments.toString();
  }
}
