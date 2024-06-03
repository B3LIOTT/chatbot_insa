import 'package:chatbot_insa/local/config/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PromptTextFiled extends StatefulWidget {
  const PromptTextFiled({super.key});

  @override
  _PromptTextFiledState createState() => _PromptTextFiledState();
}

class _PromptTextFiledState extends State<PromptTextFiled> {
  String _message = "";
  TextEditingController _controller = TextEditingController();


  Widget sendButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(20)
        ),
        child: IconButton(
          icon: const Icon(
            Icons.send_rounded,
            color: AppTheme.white,
          ),
          onPressed: () {
            _controller.clear();
          }
        )
      ),
    );
  }

  TextField txtField() {
    return TextField(
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      controller: _controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        hintText: "Que voulez-vous savoir ?",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppTheme.txtFieldColor
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: AppTheme.primaryColor
          )
        )
      ),
      onChanged: (value) {
        _message = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h*0.10,
      width: w,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: MediaQuery.of(context).padding.bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: txtField(),
          ),
          sendButton()
        ],
      ),
    );
  }

}