class AnswerModel {
  final String content;
  final String index;

  AnswerModel({required this.content, required this.index});
  factory AnswerModel.fromJson(jsondata) {
    return AnswerModel(
      content: jsondata["content"],
      index: jsondata["id"],
    );
  }
}
