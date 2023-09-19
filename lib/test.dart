import 'package:flutter/material.dart';


class Account_details extends StatefulWidget {
  const Account_details({Key key}) : super(key: key);

  @override
  State<Account_details> createState() => _Account_detailsState();
}

class _Account_detailsState extends State<Account_details> {
  TextEditingController account_no = TextEditingController();
  TextEditingController IFSC = TextEditingController();
  TextEditingController Branch = TextEditingController();
  TextEditingController Bank_Name = TextEditingController();
  TextEditingController UPI = TextEditingController();
  TextEditingController Ac_holder = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          TextField(
            // controller: updateyear,
            // focusNode: focusyear,
            keyboardType: TextInputType.name,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFF075E54),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
              hintText: "age",
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          TextField(
            // controller: updateyear,
            // focusNode: focusyear,
            keyboardType: TextInputType.name,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFF075E54),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
              hintText: "age",
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          TextField(
            // controller: updateyear,
            // focusNode: focusyear,
            keyboardType: TextInputType.name,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFF075E54),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
              hintText: "age",
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          TextField(
            // controller: updateyear,
            // focusNode: focusyear,
            keyboardType: TextInputType.name,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFF075E54),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
              hintText: "age",
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          TextField(
            // controller: updateyear,
            // focusNode: focusyear,
            keyboardType: TextInputType.name,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFF075E54),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
              hintText: "age",
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),
          TextField(
            // controller: updateyear,
            // focusNode: focusyear,
            keyboardType: TextInputType.name,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFF075E54),
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(bottom: 13.0,left: 10),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Colors.white, width: 1),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                borderSide: BorderSide(color: Color(0xFFF65054)),
              ),
              prefixIcon: Icon(Icons.person, color: Colors.white,),
              hintText: "age",
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: 15,
              ),
            ),
          ),

        ],
      ),
    ));
  }
}
