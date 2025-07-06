import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'services/auth_service.dart';
import 'screens/notes_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showLogin = true;
  bool isLoading = false;
  String? error;

  final AuthService _authService = AuthService();
  User? user;

  void switchScreen() {
    setState(() {
      showLogin = !showLogin;
      error = null;
    });
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void setError(String? value) {
    setState(() {
      error = value;
    });
  }

  Future<void> handleLogin(String email, String password) async {
    setLoading(true);
    try {
      final credential = await _authService.signIn(email, password);
      user = credential.user;
      setError(null);
      if (user != null) {
        Provider.of<NotesProvider>(context, listen: false).fetchNotes(user!.uid);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NotesScreen(uid: user!.uid)),
        );
      }
    } catch (e) {
      setError(e.toString());
    }
    setLoading(false);
  }

  Future<void> handleSignUp(String email, String password) async {
    setLoading(true);
    try {
      final credential = await _authService.signUp(email, password);
      user = credential.user;
      setError(null);
      if (user != null) {
        Provider.of<NotesProvider>(context, listen: false).fetchNotes(user!.uid);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => NotesScreen(uid: user!.uid)),
        );
      }
    } catch (e) {
      setError(e.toString());
    }
    setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotesProvider()),
      ],
      child: MaterialApp(
        title: 'Shinex Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: showLogin
            ? LoginScreen(
                onLogin: handleLogin,
                onSwitchToSignUp: switchScreen,
                isLoading: isLoading,
              )
            : SignUpScreen(
                onSignUp: handleSignUp,
                onSwitchToLogin: switchScreen,
                isLoading: isLoading,
              ),
      ),
    );
  }
}
