
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/fontstyle_utils.dart';
import '../utils/validation.dart';


enum ValidationType { Password, Email, PNumber, name,None, address, city, pincode, state }

typedef OnChangeString = void Function(String value);

class CommonTextField extends StatefulWidget {

  final String? initialValue;
  final bool? isValidate;
  final bool? readOnly;
  final TextInputType? textInputType;
  final ValidationType? validationType;
  final String? regularExpression;
  final int? inputLength;
  final String? hintText;
  final String? validationMessage;
  final TextEditingController? textEditController;
  final int? maxLine;
  Widget? sIcon;
  Widget? pIcon;
  final bool? obscureValue;
  final bool? withOutIcon;
  final double? containerHeight;
  final Color? containerBgColor;
  final TextStyle? hintStyle;
  final OnChangeString? onChange;
  final bool? isAddress;
  final TextCapitalization? textCapitalization;
  final bool? useRegularExpression;
  final bool? prefix;
  final Color? borderColor;
  final TextStyle? style;
  final String? prefixText;
  final Widget? label;
  final Color? textColor;
  final String? Function(String?)? validator;

  CommonTextField(
      {super.key,

        this.regularExpression = '',
        this.isValidate ,
        this.textEditController,
        this.textInputType,
        this.validator,
        this.validationType = ValidationType.None,
        this.inputLength,
        this.readOnly = false,
        this.hintText,
        this.validationMessage,
        this.maxLine,
        this.sIcon,
        this.onChange,
        this.initialValue ,
        this.obscureValue,
        this.withOutIcon,
        this.containerHeight,
        this.containerBgColor,
        this.hintStyle,
        this.isAddress,
        this.textCapitalization,
        this.useRegularExpression,
        this.prefix,
        this.borderColor,
        this.style,
        this.prefixText,
        this.pIcon,
        this.label, this.textColor});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  Widget? pIcon;

  /// PLEASE IMPORT GETX PACKAGE
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: TextFormField(

            autofocus: false,

            style: TextStyle(
                fontFamily: FontUtils.poppins,fontSize: 14.sp,fontWeight: FontWeight.w500
              // color: ColorUtils.primaryColor,
            ),
            onChanged: widget.onChange,
            readOnly: widget.readOnly ?? false,
            cursorColor: Colors.teal,
            maxLines: widget.maxLine ?? 1,
            controller: widget.textEditController,

            ///Validation
            validator: (value) {
              return widget.isValidate == false
                  ? null
                  : widget.validationType == ValidationType.Email
                  ? ValidationMethod.validateEmail(value)
                  : widget.validationType == ValidationType.Password
                  ? ValidationMethod.validatePassword(value)
                  : widget.validationType == ValidationType.PNumber
                  ? ValidationMethod.validatePhoneNo(value)
                  : widget.validationType == ValidationType.name
                  ? ValidationMethod.validateFullName(value!)
                  : widget.validationType == ValidationType.address
                  ? ValidationMethod.validateAddress(value)
                  : widget.validationType == ValidationType.pincode
                  ? ValidationMethod.validateZipCode(value)
                  : widget.validationType == ValidationType.None
                  ? ValidationMethod.validateIsRequired(value)
                  : ValidationMethod.validateIsRequired(value);
            },


            textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,


            inputFormatters: widget.regularExpression!.isEmpty
                ? [
              LengthLimitingTextInputFormatter(widget.inputLength),
              NoLeadingSpaceFormatter(),
            ]
                : [
              LengthLimitingTextInputFormatter(widget.inputLength),
              FilteringTextInputFormatter.allow(RegExp(
                  widget.regularExpression ??
                      RegularExpression.alphabetDigitSpacePattern_)),

              NoLeadingSpaceFormatter(),

            ],


            textInputAction:
            widget.maxLine == 4 ? TextInputAction.none : TextInputAction.done,


            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: widget.borderColor ?? Colors.grey.withOpacity(0.8),width: 1.5)
              ),

              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),


              filled: false,
              // fillColor: Colors.black45,
              // fillColor: ColorUtils.lightBlack,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),


              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey,width: 1.5)
              ) ,


              errorStyle: const TextStyle(color: Colors.red),
              isDense: true,
              prefixIcon: widget.pIcon,

              suffixIconConstraints:
              const BoxConstraints(maxWidth: 40, maxHeight: 40),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 3),
                child: widget.sIcon ?? const SizedBox(),
              ),
              hintText: widget.hintText,

              // hintStyle: TextStyle(
              //     color: ColorUtils.primaryColor,
              //     // color: Colors.grey,
              //     // fontFamily: AssetsUtils.poppins,
              //     fontSize: 16
              //
              // ),

              label: widget.label,


            ),

            keyboardType: widget.textInputType ?? TextInputType.text,
            initialValue: widget.initialValue,

            obscureText: widget.obscureValue ?? false,
            enabled: !widget.readOnly!,


          ),
        ),

      ],
    );
  }


}



class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

