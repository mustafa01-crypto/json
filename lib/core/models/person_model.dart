class Person {
    int id;
    int parentId;
    String picture;
    String name;

    Person(
        {this.id,
          this.name,
          this.parentId,
          this.picture
            });

    Person.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        name = json['name'];
        parentId = json['parentId'];
        picture = json['picture'];

    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['parentId'] = this.parentId;
        data['picture'] = this.picture;
        return data;
    }
}