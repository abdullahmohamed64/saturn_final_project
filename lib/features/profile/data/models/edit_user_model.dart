class EditUserResposeModel {
  final String status;
  final String message;


  EditUserResposeModel({required this.status,required this.message});

  EditUserResposeModel.fromJson(Map<String, dynamic> json)
    : status = json['status'],
      message = json['message'];
  //  factory EditUserResposeModel.fromJson(Map<String, dynamic> json){

  // return EditUserResposeModel(status: json['status'], message: json['message']);
  //  }
}
