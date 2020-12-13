part of 'pages.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Account"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
              flex: 9,
              child: Container(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(60)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: RaisedButton.icon(
                        icon: Icon(Icons.photo_camera),
                        label: Text("Edit Photo"),
                        onPressed: () {},
                        textColor: Colors.white,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 40),
                    Container(
                      child: Text(
                        "username",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Text(
                        "email",
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
              ),
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