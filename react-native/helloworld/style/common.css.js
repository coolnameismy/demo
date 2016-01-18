/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
} = React;

var CommonStyle = StyleSheet.create({
	container: {
	  flex: 1,
	  justifyContent: 'center',
	  alignItems: 'center',
	  backgroundColor: '#F5FCFF',   
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
	   color:'black'
	},
    center:{
   	 	justifyContent:'center',
    	alignItems:'center',
  	},
});


module.exports = CommonStyle;
