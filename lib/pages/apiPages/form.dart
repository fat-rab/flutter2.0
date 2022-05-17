import 'package:flutter/material.dart';

class FormApi extends StatelessWidget {
  const FormApi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("form")),
      body: const FormDemo(),
      //body: const FormContainer(),
    );
  }
}

class FormDemo extends StatefulWidget {
  const FormDemo({Key? key}) : super(key: key);

  @override
  _FormDemoState createState() => _FormDemoState();
}

class _FormDemoState extends State<FormDemo> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // 自动验证模式：将仅在其内容更改后自动验证
      // 在这边自动验证会导致在其中一个input输入的时候，自动验证其他所有form中的input
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
                label: Text("用户名"),
                hintText: "请输入用户名",
                prefixIcon: Icon(Icons.person)),
            // 自动验证模式：将仅在其内容更改后自动验证
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              return val!.trim().isNotEmpty ? null : "用户名不能为空";
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
                label: Text("密码"),
                hintText: "请输入密码",
                prefixIcon: Icon(Icons.lock)),
            // 自动验证模式：将仅在其内容更改后自动验证
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              return val!.trim().length > 5 ? null : "密码不能少于6位";
            },
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if ((_formKey.currentState as FormState).validate()) {
                  print("验证通过1");
                }
              },
              child: const Text("登录1"),
            ),
          ),
          SizedBox(
            width: double.infinity,
            // 通过Builder获取ElevatedButton所在widget树的真正context，
            // 如果直接使用Form.of(context)的话，获取的是_FormDemoState的context
            child: Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  if (Form.of(context)!.validate()) {
                    print("验证通过2");
                  }
                },
                child: const Text("登录2"),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class FormContainer extends StatefulWidget {
  const FormContainer({Key? key}) : super(key: key);

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  bool _switchSelected = false;
  bool _switchListSelected = false;
  bool? _checkboxSelected = false; // _checkboxSelected可以为null
  bool? _checkboxListSelected = false;
  late String _password; // late 显式声明一个非空变量，但不初始化
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 设置TextField的值
    _controller.text = "1231230";
    // 选中TextField值，从第三个开始选
    _controller.selection =
        TextSelection(baseOffset: 2, extentOffset: _controller.text.length);
    //监听输入改变
    _controller.addListener(() {
      //print(_controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          // 编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件
          controller: _controller,
          autofocus: true, //自动聚焦
          decoration: const InputDecoration(
              labelText: "用户名",
              hintText: "请输入用户名",
              prefixIcon: Icon(Icons.person),
              // 失焦的下划线
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow)),
              // 聚焦下划线
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green))),
        ),
        TextField(
          obscureText: true, //使用*替代输入
          decoration: const InputDecoration(
              labelText: "密码", hintText: "请输入密码", prefixIcon: Icon(Icons.lock)),
          onChanged: (value) {
            setState(() {
              _password = value;
            });
          },
        ),
        Switch(
            value: _switchSelected,
            onChanged: (val) {
              setState(() {
                _switchSelected = val;
              });
            }),
        SwitchListTile(
            title: const Text("SwitchListTile"),
            value: _switchListSelected,
            onChanged: (val) {
              setState(() {
                _switchListSelected = val;
              });
            }),
        Checkbox(
            value: _checkboxSelected,
            tristate: true, //此时Checkbox可以有三种状态，val为true,false,null
            onChanged: (val) {
              setState(() {
                _checkboxSelected = val;
              });
            }),
        // CheckboxListTile 默认是撑满父组件，如果需要限制宽度，则需要添加Container
        SizedBox(
          width: 300,
          child: CheckboxListTile(
              title: const Text("checkboxList"),
              subtitle: const Text("二级标题"),
              //图标
              secondary: const Icon(Icons.person),
              value: _checkboxListSelected,
              //checkbox在前
              controlAffinity: ListTileControlAffinity.leading,
              tristate: true,
              onChanged: (val) {
                setState(() {
                  _checkboxListSelected = val;
                });
              }),
        ),
      ],
    );
  }
}
