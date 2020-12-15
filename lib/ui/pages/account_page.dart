part of 'pages.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  User _auth = FirebaseAuth.instance.currentUser;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  bool isLoading = false;
  String img, name, email;

  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseImage() async {
    final selectedImage = await imagePicker.getImage(
      source: ImageSource.gallery, imageQuality: 50
      );
      setState(() {
        imageFile = selectedImage;
      });
  }

  void getUserUpdate() async{
    userCollection.doc(_auth.uid).snapshots().listen( (event) {
      img = event.data()['profilePicture'];
      name = event.data()['name'];
      email = event.data()['email'];
      if(img == ""){
        img = null;
      }
      setState(() {});
    });
  }

  void initState(){
    getUserUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                            img ??
                                "https://firebasestorage.googleapis.com/v0/b/startapp-ece15.appspot.com/o/assets%2Fdefault-user-image.png?alt=media&token=9807934a-cf98-4433-9c22-c013e6fc1859",
                          ),
                        ),
                    SizedBox(height: 20),
                    Container(
                      child: RaisedButton.icon(
                        icon: Icon(Icons.photo_camera),
                        label: Text("Edit Photo"),
                        onPressed: () async{
                          await chooseImage();
                          await UserServices.updateProfilePicture(_auth.uid, imageFile).then((value) {
                            if(value){
                            Fluttertoast.showToast(
                              msg: "Update Profile Succesfull!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }else{
                            Fluttertoast.showToast(
                              msg: "Failed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                          });
                        },
                        textColor: Colors.white,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      child: Text(
                        name ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        email ?? '',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        offset: Offset(0, 2),
                        blurRadius: 7)
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              flex: 1,
              child: Container(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("SignOut Confirmation"),
                              content: Text("Are you sure to SignOut?"),
                              actions: [
                                FlatButton(
                                    onPressed: () async {
                                      setState(
                                        () {
                                          isLoading = true;
                                        },
                                      );
                                      await AuthServices.signout().then(
                                        (value) {
                                          if (value) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return SignInPage();
                                                },
                                              ),
                                            );
                                            setState(
                                              () {
                                                isLoading = false;
                                              },
                                            );
                                          } else {
                                            setState(
                                              () {
                                                isLoading = false;
                                              },
                                            );
                                          }
                                        },
                                      );
                                    },
                                    child: Text("Yes")),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                child: Text("No"))
                              ],
                            );
                          }
                        );
                      },
                    padding: EdgeInsets.all(12),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    child: Text("Sign Out"),
                  ),
                ),
              )
            ),
            isLoading == true
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    child: SpinKitFadingCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}