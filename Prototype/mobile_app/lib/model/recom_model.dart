class TrustedContactModel {
  String fName;
  String lName;
  String fullName;
  String mobile;

  TrustedContactModel(
      {required this.fName,
      required this.lName,
      required this.fullName,
      required this.mobile});

  TrustedContactModel.fromJson(Map<String, dynamic> json)
      : fName = json['fName'] as String,
        lName = json['lName'] as String,
        fullName = json['fullName'] as String,
        mobile = json['mobile'] as String;

  Map<String, dynamic> toJson() => {
        'fName': fName,
        'lName': lName,
        'fullName': fullName,
        'mobile': mobile,
      };
}

class RecommendationModel {
  TrustedContactModel recommender;
  TrustedContactModel referee;

  RecommendationModel({required this.recommender, required this.referee});

  static List<RecommendationModel> getRecommendations() {
    List<RecommendationModel> ret = <RecommendationModel>[];

    RecommendationModel rec1 = RecommendationModel(
      recommender: TrustedContactModel(
          fName: 'John',
          lName: 'Doe',
          fullName: 'John Doe',
          mobile: '08012345678'),
      referee: TrustedContactModel(
          fName: 'Jane',
          lName: 'Doe',
          fullName: 'Jane Doe',
          mobile: '08012345678'),
    );

    RecommendationModel rec2 = RecommendationModel(
      recommender: TrustedContactModel(
          fName: 'Ocean',
          lName: 'Mcdonald',
          fullName: 'Ocean Mcdonald',
          mobile: '0912345678'),
      referee: TrustedContactModel(
          fName: 'Ace',
          lName: 'Able',
          fullName: 'Ace Able Trades',
          mobile: '07901234567'),
    );

    RecommendationModel rec3 = RecommendationModel(
      recommender: TrustedContactModel(
          fName: 'Ram',
          lName: 'Ramayan',
          fullName: 'Ram Ramayan',
          mobile: '06034567890'),
      referee: TrustedContactModel(
          fName: 'Krishna',
          lName: 'Mahabharat',
          fullName: 'Krishna Mahabharat',
          mobile: '06098765432'),
    );

    ret.add(rec1);
    ret.add(rec2);
    ret.add(rec3);

    //return <RecommendationModel>[rec1, rec2, rec3];
    return ret;
  }
}
