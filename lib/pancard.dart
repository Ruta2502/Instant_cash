import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:instant_cash/view/docment_model.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class PancardScreen extends StatefulWidget {
  const PancardScreen({super.key});

  @override
  State<PancardScreen> createState() => _PancardScreenState();
}

class _PancardScreenState extends State<PancardScreen> {
  final picker = ImagePicker();
  File? _image;
  late DocumentModel documentModel;
  late String aadarNumber = "";

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.camera_alt_outlined),
                    title: new Text('Camera'),
                    onTap: () => {
                          Navigator.pop(context),
                          pickGalleryImage(context, "camera")
                        }),
                new ListTile(
                  leading: new Icon(Icons.folder),
                  title: new Text('Gallery'),
                  onTap: () => {
                    Navigator.pop(context),
                    pickGalleryImage(context, "gallery")
                  },
                ),
              ],
            ),
          );
        });
  }

  Future pickGalleryImage(BuildContext context, String pickerType) async {
    late XFile pickedFile;
    switch (pickerType) {
      case "gallery":
        pickedFile = (await picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        ))!;
        break;

      case "camera": // CAMERA CAPTURE CODE
        pickedFile = (await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 50,
            preferredCameraDevice: CameraDevice.rear))!;
        break;
    }
    File imageFile = File(pickedFile.path);

    setState(() {
      _image = imageFile;
    });
  }

  aadhar_doc(File? image) async {
    var responseJson;

    Map<String, String> headers = {
      'Content-type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      "Authorization":
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTcwMDg5NzY3MywianRpIjoiZmRlYTZiMTItNWNlNC00N2YzLTgwMDEtMzlkNjUyNjFjZTVkIiwidHlwZSI6ImFjY2VzcyIsImlkZW50aXR5IjoiZGV2LmNvbnNvbGVfMnllc2tiaXc5ZXp4aXg4YWJqcGl1Mmx6ajF3QHN1cmVwYXNzLmlvIiwibmJmIjoxNzAwODk3NjczLCJleHAiOjIwMTYyNTc2NzMsInVzZXJfY2xhaW1zIjp7InNjb3BlcyI6WyJ3YWxsZXQiXX19.UKz36dsJEh2R6rmswDBeOFi4IOCX6K8JyuwsxRljHv0'
    };
    var url = "https://kyc-api.aadhaarkyc.io/api/v1/ocr/aadhaar";
    var request = new http.MultipartRequest("POST", Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath(
      "file",
      image!.path,
      contentType: MediaType('multipart/form-data', 'multipart/form-data'),
    ));

    request.headers.addAll(headers);
    var respond = await request.send();
    var response = await http.Response.fromStream(respond);

    if (response.statusCode == 200) {
      try {
        responseJson = json.decode(response.body.toString());
        Map<String, dynamic> presh = await responseJson;
        documentModel = DocumentModel.fromJson(presh);
        aadarNumber = documentModel.data.ocrFields[0].aadhaarNumber.value;
        _panUserNumberController.text =
            documentModel.data.ocrFields[0].aadhaarNumber.value;
        _panUserNameController.text =
            documentModel.data.ocrFields[0].fullName.value;
        setState(() {});
      } catch (e) {
        print(e);
        return response.statusCode;
      }
      return response.statusCode;
    }
  }

  TextEditingController _panUserNameController = TextEditingController();
  TextEditingController _panUserNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Pan Photo', /*fontSize: 18,fontWeight: FontWeight.w500,*/
              ),

              Card(
                  child: SizedBox(
                height: 10,
              )),
              GestureDetector(
                onTap: () {
                  _settingModalBottomSheet(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/card.png'),
                          fit: BoxFit.cover),
                      // color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: _image == null
                      ? Center(
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        )
                      : Image.file(_image!, fit: BoxFit.scaleDown),
                ),
              ),
              SizedBox(
                height: 25,
              ),

              Text(
                'Full Name', /*fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey,*/
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _panUserNameController,
                // textEditController: _panUserNameController,
              ),

              SizedBox(height: 10),

              Text(
                'Pan No.', /*fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey,*/
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _panUserNumberController,
                // textEditController: _panNumberController,
                // textInputType: TextInputType.number,
              ),

              SizedBox(height: 10),
              Text(
                'Date of Birth', /*fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey,*/
              ),
              SizedBox(
                height: 10,
              ),

              ///Date of Birth
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select D.O.B', /*fontSize: 18,fontWeight: FontWeight.w400,*/
                        ),
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Gender', /*fontSize: 16,fontWeight: FontWeight.w500,color: Colors.grey,*/
              ),
              SizedBox(
                height: 10,
              ),

              ///Gender
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6, left: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /* Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedGender == 'Select Gender' ? null : selectedGender,
                              hint: Text(
                                selectedGender,
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                              items: <String>['Male', 'Female', 'Other']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,*/ /*fontSize: 18,fontWeight: FontWeight.w400,*/ /*),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                 // selectedGender = newValue!;
                                });
                              },
                              icon: Icon(Icons.arrow_drop_down_outlined, size: 40, color: Colors.grey),
                            ),
                          ),
                        ),*/
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
