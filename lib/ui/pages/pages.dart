
import 'dart:ffi';
import 'dart:io';

import 'package:bloc_practice/main.dart';
import 'package:bloc_practice/models/models.dart';
import 'package:bloc_practice/services/product_services.dart';
import 'package:bloc_practice/services/services.dart';
import 'package:bloc_practice/ui/widgets/productcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

part 'signin_page.dart';
part 'signup_page.dart';
part 'mainmenu.dart';
part 'add_page.dart';
part 'data_page.dart';
part 'account_page.dart';
part 'datadetail_page.dart';