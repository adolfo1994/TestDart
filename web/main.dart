import 'dart:html';
import 'dart:math' show Random;
import 'dart:convert' show JSON;
import 'dart:async' show Future;

// https://www.mockable.io/a/#/space/demo7492033/rest

class UserResource {
    String path = "http://demo7492033.mockable.io/users/";
    List user_list;
    UserResource(callback){
        HttpRequest.getString(path)
            .then((String fileContents) {
                this.user_list = JSON.decode(fileContents);
                print("Users Loaded");
                callback();
            })
            .catchError((Error error) {
                print(error.toString());
            });
    }

    getUser(String name){
        for(var i=0;i<user_list.length; i++){
            if(user_list[i]["name"] == name){
                return user_list[i];
            }
        }
        return {
            "error": "User not found"
        };
    }

}
var userResource;

onUsersReady(){
    print(userResource);
    print(userResource.user_list);
    var user = userResource.getUser("Jorge");
    print(user);
    querySelector('#userName').text = "Hi ${user['name']}! Your email is ${user['email']}";
}

void main() {
    userResource = new UserResource(onUsersReady);
}

