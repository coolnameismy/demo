//联系rn中的flex布局，开发一个9宫格布局界面

/* @flow */
'use strict';

var React = require('react-native');

var {
  StyleSheet,
  View,
  Text,
  PixelRatio,
} = React;

var exLayoutView = React.createClass({
 
  render: function() {
    return (
       <View style={styles.main}>
         <View style={[styles.item,styles.center]}>
            <Text style={styles.font} onPress={this.props.clicked.bind(null,this.props.title)} >{this.props.title}</Text>
         </View>
	         
         <View style={[styles.item,styles.lineLeftRight]}>
           <View style={[styles.center,styles.flex,styles.lineCenter]}>
              <Text style={styles.font} onPress={this.props.clicked.bind(null,this.props.title)}>{this.props.items[0]}</Text>
            </View>
            <View style={[styles.center,styles.flex]}>
               <Text style={styles.font} onPress={this.props.clicked.bind(null,this.props.title)}>{this.props.items[1]}</Text>
             </View>
         </View>

         <View style={styles.item}>
           <View style={[styles.center,styles.flex,styles.lineCenter]}>
              <Text style={styles.font} onPress={this.props.clicked.bind(null,this.props.title)}>{this.props.items[2]}</Text>
            </View>
            <View style={[styles.center,styles.flex]}>
               <Text style={styles.font} onPress={this.props.clicked.bind(null,this.props.title)}>{this.props.items[3]}</Text>
             </View>
         </View>
       </View>
    );
  },
});


//加载公共样式
const styles = StyleSheet.create({
  main:{
    flexDirection:'row',
    marginTop:25,
    marginLeft:5,
    marginRight:5,
    borderRadius:5,
    backgroundColor:'#ff0067',
    height:84,
    padding:2,
  },
  item:{
    flex:1,
    height:80,
  },
  center:{
    justifyContent:'center',
    alignItems:'center',
    // flexDirection:'row',
    // backgroundColor:'red',
  },
  flex:{
    flex:1,
  },
  lineLeftRight:{
    borderLeftWidth:1/PixelRatio.get(),
    borderRightWidth:1/PixelRatio.get(),
    borderColor:'#fff',
  },
  lineCenter:{
    borderBottomWidth:1/PixelRatio.get(),
    borderColor:'#fff',
  },
  font:{
    color:'#fff',
    fontSize:16,
    fontWeight:'bold',
    // backgroundColor:'green',
    // height:40,
    // flex:1,
  }
});

module.exports = exLayoutView;
