import 'package:flutter/material.dart';
import 'package:goall/routes/app_routes.dart';
import 'package:goall/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  final PageController controller;

  SignInPage({
    this.controller,
  });

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  final Auth _authService = Auth();
  final _passwordFocus = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  void _onSubmit() async {
    _form.currentState.save();

    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await _authService
        .signUp(
      _formData['email'],
      _formData['password'],
    )
        .catchError(
      (error) {
        showInSnackBar(error.toString());
      },
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void showInSnackBar(String value) {
    bool showAction = false;

    if (value.contains("Esse e-email já está sendo utilizado")) {
      showAction = true;
    }

    _scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(value),
        action: showAction
            ? SnackBarAction(
                label: "Login",
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.LOGIN);
                },
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screen.width,
            height: screen.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: screen.width,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Go",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: "All",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromRGBO(253, 112, 146, 1),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey[100],
                              width: 2,
                            ),
                          ),
                          child: TextFormField(
                            onSaved: (value) => _formData['email'] = value,
                            onFieldSubmitted: (_) {
                              _passwordFocus.nextFocus();
                            },
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);

                              if (!emailValid) {
                                return "Digite um email válido";
                              } else {
                                return null;
                              }
                            },
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.email,
                                color: Theme.of(context).primaryColor,
                              ),
                              fillColor: Colors.white,
                              labelText: "Email",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey[100],
                              width: 2,
                            ),
                          ),
                          child: TextFormField(
                            onSaved: (value) => _formData['password'] = value,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "O campo de senha deve ter um valor";
                              } else {
                                return null;
                              }
                            },
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.lock,
                                color: Theme.of(context).primaryColor,
                              ),
                              fillColor: Colors.white,
                              labelText: "Senha",
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: screen.width,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(253, 112, 146, 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 3,
                          ),
                          child: FlatButton(
                            onPressed: _onSubmit,
                            child: _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text(
                                    "Nova conta",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Já possui uma",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      child: Text(
                        "conta?",
                        style: TextStyle(
                          color: Color.fromRGBO(253, 112, 146, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        widget.controller.animateToPage(
                          0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
