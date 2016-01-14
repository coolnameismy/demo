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
      <Text style={styles.welcome}>
       	  I am page1
       </Text>
    );
  }
});


var styles = StyleSheet.create({
	welcome: {
	    fontSize: 20,
	    textAlign: 'center',
	    margin: 10,
	    height:100,
	    color:"red"
  },
});


module.exports = Page1View;
