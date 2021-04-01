class DoctorListResponseModel {
    int id;
    String first_name;
    String last_name;
    String profile_pic;
    bool favorite;
    String primary_contact_no;
    double rating;
    String email_address;
    String qualification;
    String description;
    String specialization;
    String languagesKnown;
    String gender;
    String blood_group;
    String height;
    String weight;
    String dob;
    bool isEdited;


    DoctorListResponseModel({this.id, this.first_name, this.last_name, this.profile_pic, this.favorite, this.primary_contact_no, this.rating, this.email_address, this.qualification, this.description, this.specialization, this.languagesKnown,this.gender,this.blood_group,this.height,this.weight,this.dob,this.isEdited});

    factory DoctorListResponseModel.fromJson(Map<String, dynamic> json) {
        return DoctorListResponseModel(
            id: json['id'], 
            first_name: json['first_name'], 
            last_name: json['last_name'], 
            profile_pic: json['profile_pic'], 
            favorite: json['favorite'] is int? json['favorite']==1?true:false:json['favorite'],
            primary_contact_no: json['primary_contact_no'], 
            rating: json['rating'] is String? double.parse(json['rating']):json['rating'],
            email_address: json['email_address'], 
            qualification: json['qualification'], 
            description: json['description'], 
            specialization: json['specialization'], 
            languagesKnown: json['languagesKnown'], 
            gender: json['gender'],
            blood_group: json['blood_group'],
            height: json['height'],
            weight: json['weight'],
            dob: json['dob'],
            isEdited: json['isEdited'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['first_name'] = this.first_name;
        data['last_name'] = this.last_name;
        data['profile_pic'] = this.profile_pic;
        data['favorite'] = this.favorite;
        data['primary_contact_no'] = this.primary_contact_no;
        data['rating'] = this.rating;
        data['email_address'] = this.email_address;
        data['qualification'] = this.qualification;
        data['description'] = this.description;
        data['specialization'] = this.specialization;
        data['languagesKnown'] = this.languagesKnown;
        data['gender'] = this.gender;
        data['blood_group'] = this.blood_group;
        data['height'] = this.height;
        data['weight'] = this.weight;
        data['dob'] = this.dob;
        data['isEdited'] = this.isEdited;
        return data;
    }
}