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
      <TouchableWithoutFeedback onPress={this.goto}>
       <View style={styles.container} >
          <Text style={styles.text}>
              aaadasdsadsa
          </Text>
        </View>
      </TouchableWithoutFeedback>
      );
  },
  goto:function(){
    this.props.navigator.push({
      component:Page1View,
      title:"page1"
    });
  }
});


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    // textAlign:'center',
    backgroundColor: 'red',
   
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    height:100,
    color:"red"
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  text:{
     color:'white'
  }
});

module.exports = MainView;
