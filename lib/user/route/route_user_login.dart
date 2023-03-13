import 'package:delivery_codefactory/common/component/custom_text_form_field.dart';
import 'package:delivery_codefactory/common/const/colors.dart';
import 'package:delivery_codefactory/common/layout/layout_default.dart';
import 'package:flutter/material.dart';

class RouteUserLogin extends StatefulWidget {
  const RouteUserLogin({Key? key}) : super(key: key);

  @override
  State<RouteUserLogin> createState() => _RouteUserLoginState();
}

class _RouteUserLoginState extends State<RouteUserLogin> {
  String inputId = '';
  String inputPass = '';

  @override
  Widget build(BuildContext context) {
    return LayoutDefault(
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        SizedBox(height: 10.0),
                        Text('환영합니다!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
                        SizedBox(height: 10.0),
                        Text(
                          '이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성공적인 주문이 되길 바랍니다:)',
                          style: TextStyle(color: Color_Text),
                        ),
                      ],
                    ),
                    Image.asset('asset/img/misc/logo.png', width: MediaQuery.of(context).size.width * 3 / 4),
                    const SizedBox(height: 20.0),
                    CustomTextFormField(
                      onChanged: (value) {
                        inputId = value;
                      },
                      hintText: '이메일을 입력해주세요.',
                    ),
                    const SizedBox(height: 10.0),
                    CustomTextFormField(
                      onChanged: (value) {
                        inputPass = value;
                      },
                      hintText: '비밀번호를 입력해주세요.',
                      obscureText: true,
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color_Main,
                        ),
                        child: const Text('로그인'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(foregroundColor: Color_Text),
                        child: const Text('회원가입'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
