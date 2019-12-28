
class Category {
  int id;
  String categoryName;
  String categoryMemo;
  int totalCnt;
  int completeCnt;
//  DateTime createDt;
//  DateTime updateDt;
//  DateTime scheduleStart;
//  DateTime scheduleEnd;


  Category({
    this.id,
    this.categoryName,
    this.categoryMemo,
    this.totalCnt,
    this.completeCnt,
//    this.createDt,
//    this.updateDt,
//    this.scheduleStart,
//    this.scheduleEnd,
  });

  factory Category.fromJson(Map<String, dynamic> json) => new Category(
    id: json["id"],
    categoryName: json["categoryName"],
    categoryMemo: json["categoryMemo"],
    totalCnt: json["totalCnt"],
    completeCnt: json["completeCnt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "categoryName": categoryName,
    "categoryMemo": categoryMemo,
    "totalCnt": totalCnt,
    "completeCnt": completeCnt,
  };
}