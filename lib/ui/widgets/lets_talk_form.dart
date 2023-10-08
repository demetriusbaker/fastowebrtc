import 'package:fastowebrtc/utils/colors.dart';
import 'package:fastowebrtc/utils/text.dart';
import 'package:fastowebrtc/utils/utils.dart';
import 'package:flutter/material.dart';

final _name = TextEditingController();
final _email = TextEditingController();

class LetsTalkForm extends StatelessWidget {
  final double width;

  LetsTalkForm({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          letsTalkTitleText,
          style: TextStyle(
            fontSize: width > 775
                ? 56
                : width > 585
                    ? 48
                    : 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          letsTalkDescriptionText,
          style: TextStyle(
            fontSize: width > 775
                ? 18
                : width > 585
                    ? 15.5
                    : 13,
            color: subTextColor,
          ),
        ),
        const SizedBox(height: 48),
        width > 775
            ? _buildLargeForm()
            : width > 585
                ? _buildMediumForm()
                : _buildSmallForm(),
      ],
    );
  }

  Widget _buildLargeForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTextField(nameText, 180, _name),
        const SizedBox(width: 20),
        _buildTextField(emailText, 370, _email),
        const SizedBox(width: 20),
        SizedBox(
          height: 40,
          width: 170,
          child: ElevatedButton(
            onPressed: _sendFormData,
            child: Text(submitText),
          ),
        ),
      ],
    );
  }

  Widget _buildMediumForm() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(nameText, 180, _name),
            const SizedBox(width: 20),
            _buildTextField(emailText, 370, _email),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          width: 170,
          child: ElevatedButton(
            onPressed: _sendFormData,
            child: Text(submitText),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallForm() {
    return Column(
      children: [
        _buildTextField(nameText, 180, _name),
        const SizedBox(height: 20),
        _buildTextField(emailText, 370, _email),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          width: 170,
          child: ElevatedButton(
            onPressed: _sendFormData,
            child: Text(submitText),
          ),
        ),
      ],
    );
  }

  void _sendFormData() {
    sendFormData(_name.text, _email.text);
    _name.clear();
    _email.clear();
  }

  Widget _buildTextField(
      String hintName, double width, TextEditingController controller) {
    final oIB = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
    );
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintName,
          hintStyle: const TextStyle(color: hintTextColor),
          contentPadding: const EdgeInsets.only(
            left: 20,
            top: 15,
            bottom: 15,
          ),
          focusedBorder: oIB,
          enabledBorder: oIB,
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
