import 'package:flutter/material.dart';
import '../home.dart';
import '../home_prem.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: const Color(0xFF0288D1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Campo de usuario
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
  icon: Icon(
    _obscurePassword ? Icons.visibility : Icons.visibility_off,
  ),
  onPressed: () {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  },
),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña';
                  }
                  if (value.length < 6) {
                    return 'La contraseña debe tener al menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              
              // Botón de inicio de sesión
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
onPressed: () {
  if (_formKey.currentState!.validate()) {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (password == "premium") {
      // Usuario premium → HomePrem
      Navigator.pushReplacement(
        context,
        //MaterialPageRoute(builder: (context) => HomePrem()),
         MaterialPageRoute(builder: (context) => HomePrem(esPremium: true)),
      );
    } else {
      // Usuario normal → Home con esPremium: false
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home(esPremium: false)),
      );
    }
  }
},



/*
                  onPressed: () {
  if (_formKey.currentState!.validate()) {
    String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();
  
  bool esPremium = password == "premium";
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home(esPremium: esPremium)),
    );
  }
},*/
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0288D1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Enlace a registro
              TextButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    ),
                child: const Text(
                  '¿No tienes cuenta? Regístrate aquí',
                  style: TextStyle(color: Color(0xFF0288D1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}