class DoctorListResponseModel {
    int id;
    String first_name;
    String last_name;
    String profile_pic;
    bool favorite;
    String primary_contact_no;
    String rating;
    String email_address;
    String qualification;
    String description;
    String specialization;
    String languagesKnown;

    DoctorListResponseModel({this.id, this.first_name, this.last_name, this.profile_pic, this.favorite, this.primary_contact_no, this.rating, this.email_address, this.qualification, this.description, this.specialization, this.languagesKnown});

    factory DoctorListResponseModel.fromJson(Map<String, dynamic> json) {
        return DoctorListResponseModel(
            id: json['id'], 
            first_name: json['first_name'], 
            last_name: json['last_name'], 
            profile_pic: json['profile_pic'], 
            favorite: json['favorite'], 
            primary_contact_no: json['primary_contact_no'], 
            rating: json['rating'], 
            email_address: json['email_address'], 
            qualification: json['qualification'], 
            description: json['description'], 
            specialization: json['specialization'], 
            languagesKnown: json['languagesKnown'], 
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
        return data;
    }
}