import 'dart:io';
import 'package:ecommerce/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routeName = '/SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  late int _phoneNumber;
  File? _pickedImage;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async{
      final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.95,
            child: RotatedBox(
              quarterTurns: 2,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [ColorsConsts.gradientFStart, ColorsConsts.gradientLStart],
                    [ColorsConsts.gradientFEnd, ColorsConsts.gradientLEnd],
                  ],
                  durations: [19440, 10800],
                  heightPercentages: [0.20, 0.25],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 0,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 30.0,
                    ),
                    child: CircleAvatar(
                      radius: 71,
                      backgroundColor: ColorsConsts.gradientLEnd,
                      child: CircleAvatar(
                        backgroundColor: ColorsConsts.gradientFEnd,
                        radius: 65.0,
                        backgroundImage: _pickedImage == null
                            ? null
                            : FileImage(_pickedImage!),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 120.0,
                    left: 120.0,
                    child: RawMaterialButton(
                      elevation: 10.0,
                      fillColor: ColorsConsts.gradientLEnd,
                      padding: EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.add_a_photo,
                      ),
                      shape: CircleBorder(),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose option',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: ColorsConsts.gradientLStart,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      InkWell(
                                        onTap: _pickImageCamera,
                                        splashColor: Colors.purpleAccent,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.camera,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Camera',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsConsts.title,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _pickImageGallery,
                                        splashColor: Colors.purpleAccent,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.image,
                                                color: Colors.purpleAccent,
                                              ),
                                            ),
                                            Text(
                                              'Gallery',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: ColorsConsts.title,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: _remove,
                                        splashColor: Colors.purpleAccent,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Text(
                                              'Remove',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Name cannot be null';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Full name',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _fullName = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              labelText: 'Email Address',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _emailAddress = value!;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Password'),
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a valid Password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              labelText: 'Password',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: _obscureText,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('phone number'),
                          focusNode: _phoneNumberFocusNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _submitForm,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.phone_android),
                              labelText: 'Phone number',
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value!);
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 10),
                          ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                      color: ColorsConsts.backgroundColor),
                                ),
                              )),
                              onPressed: _submitForm,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.person,
                                    size: 18,
                                  )
                                ],
                              )),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
