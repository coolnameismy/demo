/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';
import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View,
  NavigatorIOS,
} from 'react-native';

var MainView = require("./View/MainView.ios.js");
var exLayoutView = require("./View/ex-layout.ios.js");

class helloworld extends Component {
  render() {
    return (
        <NavigatorIOS
        style={{flex:1}}
        initialRoute={{
          title: '主页',
          component: exLayoutView,
          navigationBarHidden:true,
        }} />
    );
  }
}


AppRegistry.registerComponent('helloworld', () => helloworld);
