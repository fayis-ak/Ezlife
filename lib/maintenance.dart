import 'dart:developer';
import 'dart:io';

import 'package:demo_project/home_user.dart';
import 'package:demo_project/model/maintenance.dart';
import 'package:demo_project/profile_edit.dart';
import 'package:demo_project/controller/helperprovider.dart';
import 'package:demo_project/utils/string.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class maintenance extends StatefulWidget {
  const maintenance({super.key});

  @override
  State<maintenance> createState() => _maintenanceState();
}

final diskcrip = TextEditingController();

class _maintenanceState extends State<maintenance> {
  String? url;

  @override
  Widget build(BuildContext context) {
    File? fileimage;
    ImagePicker imagePicker = ImagePicker();

    opegallery() async {
      await imagePicker.pickImage(source: ImageSource.gallery).then((xfile) {
        fileimage = File(xfile!.path);
      });
    }

    final unitno = TextEditingController();

    final Complainttype = {'Electricity', 'Water'};

    final privder = Provider.of<HelperProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("mainteance")),
          backgroundColor: Color.fromARGB(44, 24, 255, 216),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Consumer<HelperProvider>(
                  builder: (context, helper, child) {
                    return DropdownButtonFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: Complainttype.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (value) {
                        helper.selectflore(value);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Consumer<HelperProvider>(
                  builder: (context, helper, child) {
                    return FutureBuilder(
                      future: helper.fetchuserdata(auth.currentUser!.uid),
                      builder: (context, snapshot) {
                        final data = helper.usermodel;
                        final unitno = data!.rooomnumber;
                        return TextFormField(
                          readOnly: true,
                          initialValue: unitno,
                          // controller: unitno,
                          decoration: InputDecoration(
                            filled: true,
                            // labelText: "Name",
                            hintText: "Unit No",
                            // prefixIcon: Icon(Icons.person),
                            fillColor: Color(0xFFF3EEEE),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        );
                      },
                    );
                  },
                ),

                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  child: TextField(
                    controller: diskcrip,
                    maxLines: 6,
                    decoration: InputDecoration(
                      filled: true,
                      // labelText: "Name",
                      hintText: " complaint Description ",
                      // prefixIcon: Icon(Icons.person),
                      fillColor: Color(0xFFF3EEEE),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    final time = TimeOfDay.now();
                    await opegallery().then((value) async {
                      SettableMetadata metadata =
                          SettableMetadata(contentType: 'image/jpeg');
                      UploadTask uploadTask = FirebaseStorage.instance
                          .ref()
                          .child('maintance_/$time')
                          .putFile(fileimage!, metadata);
                      TaskSnapshot snapshot = await uploadTask;
                      await snapshot.ref.getDownloadURL().then((value) {
                        url = value;
                      });

                      // log('${url.toString()}=====================');
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    width: 320,
                    child: Text(
                      'Add your problem image!',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: 100,
                    height: 40,
                    child: Consumer<HelperProvider>(
                      builder: (context, helperok, child) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 12, 184, 193)),
                          onPressed: () async {
                            if (url != null) {
                              await helperok
                                  .addmaintaince(
                                MaintenanceModel(
                                  complainttype:
                                      helperok.selelctedroom.toString(),
                                  RoomNo: privder.usermodel!.rooomnumber,
                                  description: diskcrip.text,
                                  image: url.toString(),
                                  uid: auth.currentUser!.uid,
                                  maintainestatus: 'Approved',
                                ),
                              )
                                  .then((value) {
                                cherrytoast(context, 'add maintance');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => home_user(),
                                    ));
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Plesae stay image upload...')));
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('done .')));
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        );
                      },
                    )),
                //fileimage == null ? Text("loading") : Image.file(fileimage!)
              ],
            ),
          ),
        ));
  }
}
