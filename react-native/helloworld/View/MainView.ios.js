/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
  TouchableWithoutFeedback,
  TouchableOpacity,
  TouchableHighlight,
} = React;

var Page1View = require("./Page1View.ios.js");

var MainView = React.createClass({
  render: function() {
    return (
       <View style={styles.container} >
          <Text style={styles.text} onPress={this.goto}>
              布局练习
          </Text>
        </View>
      );
  },
  goto:function(){
    this.props.navigator.push({
      component:Page1View,
      title:"page1"
    });
  },
 replace:function(){
    this.props.navigator.replace({
      component:Page1View,
      title:"page1"
    });
  }
});

//加载公共样式
const styles =  require('../style/common.css.js');

module.exports = MainView;
