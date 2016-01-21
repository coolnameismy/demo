/* 

条件表达式，遍历，延展属性赋值，子元素和父元素交互

 */


/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
  TouchableWithoutFeedback,
} = React;

var props = {
	text1:'text1',
	text2:'text2',
	text3:'text3',
	name:'liuyanwei',
};


var MyNativeModule = require('NativeModules').MyNativeModule;
// console.log(require('NativeModules'));
console.log(MyNativeModule);
console.log(MyNativeModule.a + "|" + MyNativeModule.b);

var JsxSyntaxView = React.createClass({


  /* 使用延展属性赋值 {...props}  */
  render: function() {
      MyNativeModule.Hello2(function(){
        console.log(arguments);
      });

    // console.log(React.NativeModules);
    // console.log('>>>>>>>>>>');
    // console.log(MyNativeModule);
    // console.log('>>>>>>>>>>');

    return (
		<View style={styles.container}>
			<MyText  {...props}></MyText>
			<Parent name='liuyanwei'></Parent>
			<Express></Express>
			<View style={[styles.container,{flex:2}]}>
		   		<Text style={styles.text}> 
		   			本节主要演示内容：条件表达式，遍历，延展属性赋值，子元素和父元素交互
		   			参考文件JsxSyntaxView.js
		   		</Text>
		    </View>	
		</View>
    );
  }
});

var MyText = React.createClass({
  render: function() {
    return (
      <View style={[styles.container,styles.center,{marginTop:30}]}>
      	<Text style={styles.text}>{this.props.text1} | {this.props.text2} | {this.props.text3} </Text>
      </View>
    );
  }
});

var Parent = React.createClass({
  clicked:function(){
  	 this.refs.child.setState({
  	 	name:this.refs.child.state.name,
  	 });
  },
  render: function() {
    return (
    	<View style={styles.container}>
      		<Text onPress={this.clicked}> 点击通过this.refs.child修改子元素的name属性 </Text>
      		<Child name={this.props.name} ref='child'></Child>
		</View>
    );
  }
});

var Child = React.createClass({
   //设置初始化时state的值，设置一个title值并从外部获取
  getInitialState: function() {
    return {
        name:this.props.name,
    };
  },
  render: function() {
    return (
	    <View style={styles.container}>
	   		<Text style={styles.text}> {this.state.name} </Text>
	    </View>	
    );
  }
});

var Express = React.createClass({
   //设置初始化时state的值，设置一个title值并从外部获取
  getInitialState: function() {
    return {
        name:1,
    };
  },
  render: function() {
    var items = [0,1,2,3,4];
    //遍历构造数组，需要指定一个key否则会产生警告
    var dom = items.map(function(item) {
            return (
                 <Text key={item} style={{fontSize:12,color:'#fff'}}> {item} </Text>
                );
             });
    return (
	    <View style={styles.container}>
	    	{this.state.name==1?
	   			<Text style={{fontSize:12,color:'#fff'}}> ' this.state.name==1? xxx : null 条件表达式为真' </Text>
	   			:null
	    	}
	    	<View style={{flex:1,flexDirection:'row',}}>{dom}</View>
	    </View>	
    );
  }
});


var styles = StyleSheet.create({
	container:{
		flex:1,
		backgroundColor:'gray',
	},
	center:{
   	 	justifyContent:'center',
    	alignItems:'center',
  	},
  	text:{
  		color:'#fff',
  		fontSize:26,
  	}
});


module.exports = JsxSyntaxView;
