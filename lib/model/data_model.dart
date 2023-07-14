class DataModel {
  String? Code;
  String? Ccy;
  String? CcyNm_UZ;
  dynamic Nominal;
  dynamic Rate;
  String? Diff;
  String? Date;

  DataModel(this.Code, this.Ccy, this.Nominal, this.Rate,this.Diff, this.Date,this.CcyNm_UZ);

  DataModel.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    Code =json['Code'];
    CcyNm_UZ =json['CcyNm_UZ'];
    Ccy =json['Ccy'];
    CcyNm_UZ =json['CcyNm_UZ'];
    Nominal =json['Nominal'];
    Rate=json['Rate'];
    Diff=json['Diff'];
    Date =json['Date'];


  }
}
