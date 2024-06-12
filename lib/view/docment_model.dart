class DocumentModel {
  DocumentModel({
    required this.data,
    required this.statusCode,
    required this.success,
    this.message,
    required this.messageCode,
  });
  late final Data data;
  late final int statusCode;
  late final bool success;
  late final Null message;
  late final String messageCode;

  DocumentModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    statusCode = json['status_code'];
    success = json['success'];
    message = null;
    messageCode = json['message_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['status_code'] = statusCode;
    _data['success'] = success;
    _data['message'] = message;
    _data['message_code'] = messageCode;
    return _data;
  }
}

class Data {
  Data({
    required this.clientId,
    required this.ocrFields,
  });
  late final String clientId;
  late final List<OcrFields> ocrFields;

  Data.fromJson(Map<String, dynamic> json){
    clientId = json['client_id'];
    ocrFields = List.from(json['ocr_fields']).map((e)=>OcrFields.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['client_id'] = clientId;
    _data['ocr_fields'] = ocrFields.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class OcrFields {
  OcrFields({
    required this.documentType,
    required this.fullName,
    required this.gender,
    required this.motherName,
    required this.fatherName,
    required this.dob,
    required this.aadhaarNumber,
    this.imageUrl,
    required this.uniquenessId,
  });
  late final String documentType;
  late final FullName fullName;
  late final Gender gender;
  late final MotherName motherName;
  late final FatherName fatherName;
  late final Dob dob;
  late final AadhaarNumber aadhaarNumber;
  late final Null imageUrl;
  late final String uniquenessId;

  OcrFields.fromJson(Map<String, dynamic> json){
    documentType = json['document_type'];
    fullName = FullName.fromJson(json['full_name']);
    gender = Gender.fromJson(json['gender']);
    motherName = MotherName.fromJson(json['mother_name']);
    fatherName = FatherName.fromJson(json['father_name']);
    dob = Dob.fromJson(json['dob']);
    aadhaarNumber = AadhaarNumber.fromJson(json['aadhaar_number']);
    imageUrl = null;
    uniquenessId = json['uniqueness_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['document_type'] = documentType;
    _data['full_name'] = fullName.toJson();
    _data['gender'] = gender.toJson();
    _data['mother_name'] = motherName.toJson();
    _data['father_name'] = fatherName.toJson();
    _data['dob'] = dob.toJson();
    _data['aadhaar_number'] = aadhaarNumber.toJson();
    _data['image_url'] = imageUrl;
    _data['uniqueness_id'] = uniquenessId;
    return _data;
  }
}

class FullName {
  FullName({
    required this.value,
    required this.confidence,
  });
  late final dynamic value;
  late final dynamic confidence;

  FullName.fromJson(Map<String, dynamic> json){
    value = json['value'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['confidence'] = confidence;
    return _data;
  }
}

class Gender {
  Gender({
    required this.value,
    required this.confidence,
  });
  late final dynamic value;
  late final dynamic confidence;

  Gender.fromJson(Map<String, dynamic> json){
    value = json['value'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['confidence'] = confidence;
    return _data;
  }
}

class MotherName {
  MotherName({
    required this.value,
    required this.confidence,
  });
  late final dynamic value;
  late final dynamic confidence;

  MotherName.fromJson(Map<String, dynamic> json){
    value = json['value'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['confidence'] = confidence;
    return _data;
  }
}

class FatherName {
  FatherName({
    required this.value,
    required this.confidence,
  });
  late final dynamic value;
  late final dynamic confidence;

  FatherName.fromJson(Map<String, dynamic> json){
    value = json['value'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['confidence'] = confidence;
    return _data;
  }
}

class Dob {
  Dob({
    required this.value,
    required this.confidence,
    required this.yob,
  });
  late final dynamic value;
  late final dynamic confidence;
  late final dynamic yob;

  Dob.fromJson(Map<String, dynamic> json){
    value = json['value'];
    confidence = json['confidence'];
    yob = json['yob'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['confidence'] = confidence;
    _data['yob'] = yob;
    return _data;
  }
}

class AadhaarNumber {
  AadhaarNumber({
    required this.value,
    required this.confidence,
    required this.isMasked,
    required this.inputValidation,
  });
  late final dynamic value;
  late final dynamic confidence;
  late final dynamic isMasked;
  late final dynamic inputValidation;

  AadhaarNumber.fromJson(Map<String, dynamic> json){
    value = json['value'];
    confidence = json['confidence'];
    isMasked = json['is_masked'];
    inputValidation = json['input_validation'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['value'] = value;
    _data['confidence'] = confidence;
    _data['is_masked'] = isMasked;
    _data['input_validation'] = inputValidation;
    return _data;
  }
}