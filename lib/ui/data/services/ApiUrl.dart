class ApiUrl{
  ApiUrl._();
  static const String _baseUrl='https://task.teamrabbil.com/api/v1';
  static const String registration='$_baseUrl/registration';
  static const String login='$_baseUrl/login';
  static const String createTask='$_baseUrl/createTask';
  static const String taskStatusCount='$_baseUrl/taskStatusCount';
  static const String newTask='$_baseUrl/listTaskByStatus/New';
  static const String inProgress='$_baseUrl/listTaskByStatus/Progress';
  static  String deleteTask(String id)=>'$_baseUrl/deleteTask/$id';
  static String updateTask(String id, String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static String updateProfile = '$_baseUrl/profileUpdate';
  static String sendOtpToEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerify(String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String resetPassword = '$_baseUrl/RecoverResetPass';

  static String canceled= '$_baseUrl/listTaskByStatus/Canceled';
  static String completed= '$_baseUrl/listTaskByStatus/Completed';



}