class NetworkResponse{
  final int statusCode;
  final Map<String,dynamic>? body;
   bool isSuccess;

  NetworkResponse(this.isSuccess,this.statusCode, this.body);

}