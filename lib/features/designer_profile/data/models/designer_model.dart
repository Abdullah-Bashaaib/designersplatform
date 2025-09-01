class DesignerModel {
   String? designerID;
   String? designerName;
   String? designerBio;
   String? designerAvatar;
   String? designerEmail;
   int? designerPhone;

   DesignerModel({
     this.designerID,
     this.designerName,
     this.designerBio,
     this.designerAvatar,
     this.designerEmail,
     this.designerPhone,
   });

   factory DesignerModel.fromJson(Map<String, dynamic> json) {
     return DesignerModel(
       designerID: json['designerID'],
       designerName: json['designerName'],
       designerBio: json['designerBio'],
       designerAvatar: json['designerAvatar'],
       designerEmail: json['designerEmail'],
       designerPhone: json['designerPhone'],
     );
   }

   Map<String,dynamic>toMap(){
    return {
      'designerID': designerID,
      'designerName': designerName,
      'designerBio': designerBio,
      'designerAvatar': designerAvatar,
      'designerEmail': designerEmail,
      'designerPhone': designerPhone,
    };
   }

}
