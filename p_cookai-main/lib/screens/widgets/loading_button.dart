import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final Color? color;

  const LoadingButton({
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
    backgroundColor: color ?? Colors.blue, // Usa el color dado o azul por defecto
    foregroundColor: Colors.white,
  ),
  onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(width: 10),
                Text('Cargando...'),
              ],
            )
          : Text(text),
    );
  }
}
