// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.username,
        this.email,
        this.albums,
    });

    String username;
    String email;
    Albums albums;

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        albums: Albums.fromJson(json["albums"]),
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "albums": albums.toJson(),
    };
}

class Albums {
    Albums({
        this.data,
    });

    List<AlbumsDatum> data;

    factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        data: List<AlbumsDatum>.from(json["data"].map((x) => AlbumsDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AlbumsDatum {
    AlbumsDatum({
        this.photos,
    });

    Photos photos;

    factory AlbumsDatum.fromJson(Map<String, dynamic> json) => AlbumsDatum(
        photos: Photos.fromJson(json["photos"]),
    );

    Map<String, dynamic> toJson() => {
        "photos": photos.toJson(),
    };
}

class Photos {
    Photos({
        this.data,
    });

    List<PhotosDatum> data;

    factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        data: List<PhotosDatum>.from(json["data"].map((x) => PhotosDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class PhotosDatum {
    PhotosDatum({
        this.url,
    });

    String url;

    factory PhotosDatum.fromJson(Map<String, dynamic> json) => PhotosDatum(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}
