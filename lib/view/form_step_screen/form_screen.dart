
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instant_cash/bottom_bar/bottom_bar_screens.dart';
import 'package:instant_cash/commanwidget/custom_btn.dart';
import 'package:instant_cash/commanwidget/custom_toast.dart';
import 'package:instant_cash/pancard.dart';

import 'package:instant_cash/utils/comman_text.dart';
import 'package:instant_cash/view/home/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../commanwidget/custom_text_field.dart';
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../../model/docment_model.dart';
import '../payment/payment_screen.dart';




class FormStepScreen extends StatefulWidget {
  const FormStepScreen({super.key});

  @override
  State<FormStepScreen> createState() => _FormStepScreenState();
}

class _FormStepScreenState extends State<FormStepScreen> {

  int activeStep = 0; // Initial step set to 0.
  int upperBound =
      4; // upperBound MUST BE total number of icons minus 1 (4 steps - 1).

  /// Range Slider variables
  double _value = 5000;

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
        pickedFile = (

            await picker.pickImage(

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
        _panNumberController.text =
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

  ///Gender Detail Variable
  String selectedGender = 'Select Gender';

  ///Education Detail
  String selectOccupation = 'Select Occupation';
  String selectEducation = 'Select Education';
  String selectSalary = 'Select Salary';
  String selectResident = 'Select Residence';

  ///Date detail Variable
  DateTime _selectedDate = DateTime.now();
  String _formattedDate = 'Select D.O.B';

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: Get.height*0.3,
              child: CupertinoDatePicker(

                initialDateTime: _selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                    _formattedDate = DateFormat.yMMMd().format(newDate);
                  });
                },
                mode: CupertinoDatePickerMode.date,

              ),
            ),

          ],
        ),
      ),
    );
  }

  // PAN Card Detail variables
  final TextEditingController _panUserNameController = TextEditingController();
  final TextEditingController _panNumberController = TextEditingController();

  // Bank Detail variables
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _ifscNumberController = TextEditingController();


  // Validation method
  bool _validateCurrentStep() {
    switch (activeStep) {
      case 0: // Range Slider Step
        return _value != 0; // Ensure user has selected a valid amount
      case 1: // Education Detail Step
        return selectOccupation != 'Select Occupation' &&
            selectEducation != 'Select Education' &&
            selectSalary != 'Select Salary' &&
            selectResident != 'Select Residence';
      case 2: // PAN Card Detail Step
        return _image != null &&
            _panUserNameController.text.isNotEmpty &&
            _panNumberController.text.isNotEmpty && _formattedDate != 'Select D.O.B' &&
            selectedGender != 'Select Gender';
      case 3: // Bank Detail Step
        return _bankNameController.text.isNotEmpty &&
            _accountNumberController.text.isNotEmpty &&
            _ifscNumberController.text.isNotEmpty ;
      default:
        return true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.teal,
        leading:   GestureDetector(
            onTap: () {
              Get.to(()=> const BottomBarScreen());
            },
            child: const Icon(Icons.arrow_back_ios,
                color: Colors.white, size: 24)),
        title:  CustomText(
          'Cash Assist',
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,

        actions: [
          const Icon(Icons.logout, color: Colors.teal, size: 29),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              height: 90.h,
              // width: MediaQuery.of(context).size.width,
              color: Colors.teal,
              child: IconStepper(
                // stepColor: Colors.yellow,
                stepRadius: 19,
                activeStepColor: Colors.white,
                icons: const [
                  Icon(
                    Icons.linear_scale,
                    color: Colors.teal,
                  ),
                  Icon(
                    Icons.school,
                    color: Colors.teal,
                  ),
                  Icon(
                    Icons.credit_card,
                    color: Colors.teal,
                  ),
                  Icon(
                    Icons.account_balance,
                    color: Colors.teal,
                  ),
                ],

                activeStep: activeStep,
                stepColor: Colors.teal.shade100,
                lineColor: Colors.white,
                activeStepBorderColor: Colors.white,
                enableNextPreviousButtons: false,
                lineLength: 42,
                // stepReachedAnimationEffect: Curves.easeOut,
                enableStepTapping: false,

                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                  });
                },
              ),
            ),
            Column(
              children: [
                stepContent(),
                SizedBox(height: 30.h,),
                nextBtn(),
                SizedBox(height: 5.h
                  ,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Icon(Icons.security,color: Colors.green,size: 16,),
                      ),
                      SizedBox(width: 5.w
                        ,),
                      CustomText("The platform is committed to protecting the \nsecurity of the applicant's data",
                        color: Colors.grey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,

                      ),
                    ],
                  ),
                ),

              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // previousButton(),
            //       nextButton(),
            //     ],
            //   ),
            // ),
            // nextBtn(),
            // SizedBox(height: 5.h
            //   ,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            //   child: Row(
            //     children: [
            //       const Padding(
            //         padding: EdgeInsets.only(bottom: 10),
            //         child: Icon(Icons.security,color: Colors.green,size: 16,),
            //       ),
            //       SizedBox(width: 5.w
            //         ,),
            //       CustomText("The platform is committed to protecting the \nsecurity of the applicant's data",
            //       color: Colors.grey,
            //         fontSize: 11.sp,
            //         fontWeight: FontWeight.w600,
            //
            //       ),
            //     ],
            //   ),
            // ),
            // nextButton()
          ],
        ),
      ),
    );
  }

  /// Returns the next button.
  // Widget nextButton() {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height * 0.05,
  //     width: MediaQuery.of(context).size.width / 5,
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         backgroundColor: Colors.teal,
  //       ),
  //       onPressed: () {
  //         if (_validateCurrentStep()) {
  //           if (activeStep < upperBound) {
  //             setState(() {
  //               activeStep++;
  //             });
  //           } else {
  //             // Perform your final action here when "Continue" is pressed
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Form submitted successfully.')),
  //             );
  //             Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(builder: (_) =>  PaymentScreen()),
  //             );
  //           }
  //         } else {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //                 content: Text(
  //                     'Please complete the current step before proceeding.')),
  //           );
  //         }
  //       },
  //       child: CustomText(
  //         upperBound == 4 ? 'Continue' : 'Next',
  //         fontWeight: FontWeight.w500,
  //         fontSize: upperBound == 4 ? 15 : 18,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }
  Widget nextBtn() {
    // bool isBankDetailStepValid = _bankNameController.text.isNotEmpty &&
    //     _accountNumberController.text.isNotEmpty &&
    //     _ifscNumberController.text.isNotEmpty;
    return Custombutton(
      height: Get.height * 0.06,
      width: Get.width / 1.1,
      onTap: () {
        if (_validateCurrentStep()) {
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          } else {
            // Change button text to 'Continue' and go to PaymentScreen
            ToastUtils.showCustomToast(
              context: context,
              title: 'Form submitted successfully.',
              fontWeight: FontWeight.w700,
              fontSize: 11.sp,
            );
            Get.to(() =>  PaymentScreen(amount: _value,));
          }
        } else {
          ToastUtils.showCustomToast(
            context: context,
            title: 'Please complete the current step before proceeding.',
            fontWeight: FontWeight.w700,
            fontSize: 11.sp,
          );
        }
      },
      title: 'Next Step',
      fontSize: 15.sp,
    );
  }
  //
  // /// Returns the previous button.
  // Widget previousButton() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.05,
  //     width: MediaQuery.of(context).size.width / 5,
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           backgroundColor: Colors.teal),
  //       onPressed: () {
  //         if (activeStep > 0) {
  //           setState(() {
  //             activeStep--;
  //           });
  //         }
  //       },
  //       child: CustomText(
  //         'Prev',
  //         fontWeight: FontWeight.w500,
  //         fontSize: 18,
  //         color: Colors.white,
  //       ),
  //     ),
  //   );
  // }

  // Returns the content for the active step.
  Widget stepContent() {
    switch (activeStep) {
      case 0:
        return rangeSliderStep();
      case 1:
        return educationDetailStep();
      case 2:
        return panCardDetailStep();
      case 3:
        return bankDetailStep();
      default:
        return rangeSliderStep();
    }
  }

  // Content for Range Slider step
  Widget rangeSliderStep() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h,),
            Container(
              height: Get.height/4.5,
              width: Get.width /1,

              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.tealAccent.shade400,
                      Colors.teal,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 10,),
                           child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(
                                 height: 5.h,
                               ),
                 CustomText('Get money, Instantly',
                 fontWeight: FontWeight.w600,
                   fontSize: 14.sp,
                   color: Colors.white,

                 ),
                 SizedBox(
                   height: 28.h,
                 ),
                 CustomText('Loanable Amount',
                   fontWeight: FontWeight.w500,
                   fontSize: 12.sp,
                   color: Colors.white,

                 ),
                 // SizedBox(
                 //   height: 5.h,
                 // ),
                 CustomText('₹ 3,00,000',
                   fontWeight: FontWeight.w600,
                   fontSize: 22.sp,
                   color: Colors.white,

                 ),
                             ],
                           ),
                         ),
                    Container(
                      height: 120.h,
                      width: 140.w,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(image: AssetImage('assets/image/loanProcess.png'),fit: BoxFit.cover)
                      ),
                    ),
                    // Image.asset('assets/image/loanProcess.png',scale: 5.4),

                  ],
                ),
              ),

            ),
            SizedBox(height: 30.h,),
            Container(
              alignment: Alignment.center,
              height: 350.h,
              width: Get.width,
      
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.3),
                border: Border.all(color: Colors.teal,width: 1.8)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.h,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: CustomText('Set  Amount', fontSize: 14.sp,fontWeight: FontWeight.w600,),
                  ),
      
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8.0,
      
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0), // Increase the thumb size
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0), // Increase the overlay size
                    ),
                    child: Slider(
      
                      activeColor: Colors.teal,
                      inactiveColor: Colors.teal.shade200,
                      value: _value,
                      min: 5000,
                      max: 300000,
                      divisions: ((300000 - 5000) / 5000).toInt(),
                      onChanged: (double value) {
                        setState(() {
                          _value = value.roundToDouble();
                        });
                      },
                      label: '${_value.toInt()}',
                    ),
                  ),

                  SizedBox(height: 30.h,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 180.h,
                          width: 140.w,
                          decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.teal,width: 1.5)
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText('Loan Amount',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              CustomText('Rs.${_value.toInt()}',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 80.h,
                                width: 110.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image: AssetImage('assets/image/loan_icon.png'), fit: BoxFit.cover),
                                ),
                              ),

                            ],
                          ),
                        ) ,
                        Spacer(),
                        Container(
                          height: 180.h,
                          width: 140.w,
                         decoration: BoxDecoration(
                           color: Colors.teal.withOpacity(0.2),
                           borderRadius: BorderRadius.circular(15),
                           border: Border.all(color: Colors.teal,width: 1.5)
                         ),
                          child:  Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText('Interest Rate',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText('1.99 %\n Per Annul',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                height: 60.h,
                                width: 110.h,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(image: AssetImage('assets/image/interest_rate.png'), fit: BoxFit.fill),
                                ),
                              ),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
      
                ],
              ),
            ),
      
      

          ],
        ),
      ),
    );
  }

  // Content for Education Detail step
  Widget educationDetailStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText(
              'Education Details',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 26.h,
            ),

            ///Occupation
            CustomText(
              'Occupation',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
            ),
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
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectOccupation == 'Select Occupation'
                                  ? null
                                  : selectOccupation,
                              hint: CustomText(
                                selectOccupation,
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              items: <String>[
                                'Industry',
                                'Business',
                                'Company',
                                'Farmer',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(
                                    value,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue1) {
                                setState(() {
                                  selectOccupation = newValue1!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),

            ///Education
            CustomText(
              'Education',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
            ),
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
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectEducation == 'Select Education'
                                  ? null
                                  : selectEducation,
                              hint: CustomText(
                                selectEducation,
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              items: <String>[
                                'Not Educated',
                                'Primary School',
                                'Secondary School',
                                'High School'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(
                                    value,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue2) {
                                setState(() {
                                  selectEducation = newValue2!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),

            ///Salary
            CustomText(
              'Salary',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
            ),
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
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectSalary == 'Select Salary'
                                  ? null
                                  : selectSalary,
                              hint: CustomText(
                                selectSalary,
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              items: <String>[
                                '<₹15000',
                                '₹150001 - ₹25000 ',
                                '₹250001 - ₹35000',
                                '₹350001 - ₹45000',
                                '₹450001 - ₹55000'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(
                                    value,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue3) {
                                setState(() {
                                  selectSalary = newValue3!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 18.h,
            ),

            ///Type Of Residence
            CustomText(
              'Type Of Residence',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
            ),
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
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectResident == 'Select Residence'
                                  ? null
                                  : selectResident,
                              hint: CustomText(
                                selectResident,
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              items: <String>[
                                'Personal',
                                'Rent',
                                'Other'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(
                                    value,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue4) {
                                setState(() {
                                  selectResident = newValue4!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Content for PAN Card Detail step
  Widget panCardDetailStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText(
              'Pan Photo',
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),

            SizedBox(height: 20.h,),
            GestureDetector(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/image/card.png'),
                        fit: BoxFit.cover),
                    // color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 1.1)),
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
                    : Container(
                    height: MediaQuery.of(context).size.height / 4.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                      image: DecorationImage(image: FileImage( _image!),fit: BoxFit.cover)
                    ),
                    ),

              ),
            ),
            SizedBox(
              height: 25.h
              ,
            ),

            CustomText(
              'Full Name',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),

            CommonTextField(
              textEditController: _panUserNameController,

            ),

            SizedBox(height: 10.h),

            CustomText(
              'Pan No.',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),

            CommonTextField(
              textEditController: _panNumberController,
              textInputType: TextInputType.number,
            ),

            SizedBox(
              height: 8.h,
            ),
            CustomText(
              'Date of Birth',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
            ),

            ///Date of Birth
            GestureDetector(
              onTap: _showDatePicker,
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
                      CustomText(

                        _formattedDate,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,

                      ),
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomText(
              'Gender',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
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
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedGender == 'Select Gender'
                                  ? null
                                  : selectedGender,
                              hint: CustomText(
                                selectedGender,
                                color: Colors.grey,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              items: <String>[
                                'Male',
                                'Female',
                                'Other'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(
                                    value,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGender = newValue!;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_outlined,
                                  size: 30, color: Colors.grey),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  // Content for Bank Detail step
  Widget bankDetailStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              'Bank Details',
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomText(
              'Bank Name',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),

            CommonTextField(
              textEditController: _bankNameController,
              textInputType: TextInputType.name,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              'Bank Account Number',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),

            CommonTextField(
              textEditController: _accountNumberController,
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              'Bank Ifsc Code',
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),

            CommonTextField(
              textEditController: _ifscNumberController,
              textInputType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
