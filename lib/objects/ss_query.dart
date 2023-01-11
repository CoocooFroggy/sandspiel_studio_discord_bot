import 'package:nyxx/nyxx.dart';

/// This class is not a request to SS. It is the response under the path
/// /api/query.
class SSQuery {
  List<Post>? posts;
  int? offset;

  SSQuery({this.posts, this.offset});

  List<EmbedBuilder>? toEmbeds() {
    if (posts == null) {
      return null;
    }

    List<EmbedBuilder> embeds = [];
    for (Post post in posts!) {
      EmbedBuilder eb = EmbedBuilder();
      eb.title = post.title;
      eb.imageUrl = post.thumbnailUrl;
      eb.author = EmbedAuthorBuilder()
        ..name = post.user?.name
        ..iconUrl = post.user?.image;
      embeds.add(eb);
    }
    return embeds;
  }

  SSQuery.fromJson(Map<String, dynamic> json) {
    if (json['posts'] != null) {
      posts = <Post>[];
      json['posts'].forEach((v) {
        posts!.add(Post.fromJson(v));
      });
    }
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    return data;
  }
}

class Post {
  int? id;
  String? createdAt;
  String? title;
  int? views;
  String? metadata;
  String? codeHash;
  bool? public;
  Parent? parent;
  List<Children>? children;
  User? user;
  String? featuredAt;
  Count? cCount;

  Post(
      {this.id,
      this.createdAt,
      this.title,
      this.views,
      this.metadata,
      this.codeHash,
      this.public,
      this.parent,
      this.children,
      this.user,
      this.featuredAt,
      this.cCount});

  String? get thumbnailUrl {
    if (id == null) return null;
    return 'https://storage.googleapis.com/sandspiel-studio/creations/$id.gif';
  }

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    title = json['title'];
    views = json['views'];
    metadata = json['metadata'];
    codeHash = json['codeHash'];
    public = json['public'];
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(Children.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    featuredAt = json['featuredAt'];
    cCount = json['_count'] != null ? Count.fromJson(json['_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['title'] = title;
    data['views'] = views;
    data['metadata'] = metadata;
    data['codeHash'] = codeHash;
    data['public'] = public;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['featuredAt'] = featuredAt;
    if (cCount != null) {
      data['_count'] = cCount!.toJson();
    }
    return data;
  }
}

class Parent {
  int? id;
  bool? public;

  Parent({this.id, this.public});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['public'] = public;
    return data;
  }
}

class Children {
  int? id;
  bool? public;

  Children({this.id, this.public});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    public = json['public'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['public'] = public;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? image;

  User({this.id, this.name, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Count {
  int? stars;

  Count({this.stars});

  Count.fromJson(Map<String, dynamic> json) {
    stars = json['stars'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stars'] = stars;
    return data;
  }
}
