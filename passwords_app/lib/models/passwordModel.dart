class PasswordModel {
  final title;
  final url;
  final desk;
  final password;
  final important;

  PasswordModel({this.password ="0000000", this.title = "nothing", this.url = "nothing", this.desk = "nothing", this.important = 0});

  toMap(){
    return {
      "title" : this.title,
      "url" : this.url,
      "password" : this.password,
      "import": this.important,
      "desk" : this.desk
    };
  }

}