/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
} = React;

var Page1View = React.createClass({
  render: function() {
    return (
       <View style={styles.container}>
	       <Text style={styles.welcome} onPress={this.clicked}>
	       	  I am page1 点击返回 
	       </Text>
       </View>
    );
      // <View style={styles.container}>
      //   <Text style={styles.welcome}>
      //     Welcome to React Native!
      //   </Text>
      //   <Text style={styles.instructions}>
      //     To get started, edit index.android.js
      //   </Text>
      //   <Text style={styles.instructions}>
      //     Shake or press menu button for dev menu
      //   </Text>
      // </View>
  },
  clicked:function(){
  	this.props.navigator.pop();
  }

});


//加载公共样式
const styles =  require('../style/common.css.js');

module.exports = Page1View;
