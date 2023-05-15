class MessageModel{
  int? senderId;
  int? receiverId;
  String? message;
  String? messageTime;


  MessageModel(
      this.senderId, this.receiverId, this.message,this.messageTime);

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    message = json['message'];
    messageTime = json['messageTime'];
  }
}