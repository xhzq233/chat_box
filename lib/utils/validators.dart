/// chat_box - validators
/// Created by xhz on 28/05/2022
typedef Validator = String Function(String);

class Validators {
  static String schoolNumber(String str) {
    if (str.isEmpty) {
      return "学号不能为空";
    } else if (str.startsWith(RegExp("[Uu]"))) {
      final num = int.tryParse(str.substring(1));
      if (num != null && 201600000 < num && num < 202140000) {
        return '';
      } else {
        return "学号格式错误";
      }
    } else {
      return "学号应以u开头";
    }
  }

  static String passwd(String str) {
    if (str.isEmpty) {
      return "密码不能为空";
    } else if (!RegExp('[A-Za-z0-9]{6,16}').hasMatch(str)) {
      return '密码不合规范，需6-16个字符且仅含英文与数字';
    } else {
      return '';
    }
  }

  static String isNotEmpty(String str) => str.isNotEmpty ? '' : '不能为空';

  static String usrName(String str) {
    if (str.isEmpty) {
      return "用户名不能为空";
    } else {
      return '';
    }
  }

  static String qqNumber(String str) {
    final qqReg = RegExp("[1-9]\\d{4,10}");
    if (!qqReg.hasMatch(str)) {
      return 'QQ号码格式不符！';
    }
    return '';
  }

  static String telNumber(String str) {
    final telReg = RegExp("1[34578]\\d{9}");
    if (!telReg.hasMatch(str)) {
      return '电话号码格式不符！';
    }
    return '';
  }

  static String vxNumber(String str) {
    final vxReg = RegExp("[a-zA-Z][a-zA-Z\\d_-]{5,19}");
    if (!vxReg.hasMatch(str)) {
      return '微信号格式不符！';
    }
    return '';
  }

  static String code(String str) {
    final codeReg = RegExp("\\d{6}");
    if (!codeReg.hasMatch(str) || str.length != 6) {
      return '应为6位数字!';
    }
    return '';
  }

  static bool isInt(String s) => int.tryParse(s) != null;

  static String isNum(String s) => isInt(s) ? '' : '请输入数字';

  static String noMatter(String _) => '';
}
