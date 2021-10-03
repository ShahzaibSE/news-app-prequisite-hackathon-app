import "package:flutter/material.dart";

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController paymentDetailsController =
      TextEditingController();
  //
  Widget profileView() {
    return Column(
      children: <Widget>[
        // Padding(
        //   padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       Container(height: 50, width: 50 ,child: Icon(Icons.arrow_back_ios, size: 24,color: Colors.black54,), decoration: BoxDecoration(border: Border.all(color: Colors.black54), borderRadius: BorderRadius.all(Radius.circular(10))),),
        //       Text('Profiles details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        //       Container(height: 24,width: 24)
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 70,
                child: ClipOval(
                  child: Image.asset(
                    'assets/enlightnment-app-logo.jpeg',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ))
            ],
          ),
        ),
        Expanded(
            child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black54,
                Color.fromRGBO(0, 41, 102, 1),
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
              //   child: Container(
              //     height: 60,
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           'Name',
              //           style: TextStyle(color: Colors.white70),
              //         ),
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         border: Border.all(width: 1.0, color: Colors.white70)),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: TextFormField(
                  controller: nameController,
                  key: const Key("name"),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: TextFormField(
                  controller: addressController,
                  key: const Key("address"),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Address",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                child: TextFormField(
                  controller: paymentDetailsController,
                  key: const Key("payment-card-number"),
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Payment Card Number",
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    focusColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
              //   child: Container(
              //     height: 60,
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           'Email',
              //           style: TextStyle(color: Colors.white70),
              //         ),
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         border: Border.all(width: 1.0, color: Colors.white70)),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
              //   child: Container(
              //     height: 60,
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(
              //           'Type something about yourself',
              //           style: TextStyle(color: Colors.white70),
              //         ),
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.all(Radius.circular(20)),
              //         border: Border.all(width: 1.0, color: Colors.white70)),
              //   ),
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      print("Profile Saved!");
                    },
                    child: Container(
                      height: 70,
                      width: 200,
                      child: Align(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white70, fontSize: 20),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: profileView(),
    );
  }
}
