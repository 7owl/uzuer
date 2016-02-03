/**
 * Created by zhq on 14-7-22.
 */

/*
* 为数字类型增加保留小数位几位
* */
if(!Number.prototype.toFixed()){
    Number.prototype.toFixed= function(num){
        with(Math)return round(this.valueOf()*pow(10,num))/pow(10,num);
    }
}

if (!Array.prototype.indexOf) {
    Array.prototype.indexOf = function (searchElement, fromIndex) {
        if ( this === undefined || this === null ) {
            throw new TypeError( '"this" is null or not defined' );
        }

        var length = this.length >>> 0; // Hack to convert object.length to a UInt32

        fromIndex = +fromIndex || 0;

        if (Math.abs(fromIndex) === Infinity) {
            fromIndex = 0;
        }

        if (fromIndex < 0) {
            fromIndex += length;
            if (fromIndex < 0) {
                fromIndex = 0;
            }
        }

        for (;fromIndex < length; fromIndex++) {
            if (this[fromIndex] === searchElement) {
                return fromIndex;
            }
        }

        return -1;
    };
}

function isArray(o) {
    return Object.prototype.toString.call(o) === '[object Array]';
}

var parse = function (jsonString) {
    if (window.JSON) {
        return window.JSON.parse(jsonString);
    }
    //使用到了jquery的parseJSON(s)方法
    return $.parseJSON(jsonString);
}; 
var stringify = function (obj) {
    //如果是IE8+ 浏览器(ff,chrome,safari都支持JSON对象)，使用JSON.stringify()来序列化
    if (window.JSON) {
        return JSON.stringify(obj);
    }
    var t = typeof (obj);
    if (t != "object" || obj === null) {
        // simple data type
        if (t == "string") obj = '"' + obj + '"';
        return String(obj);
    } else {
        // recurse array or object
        var n, v, json = [], arr = (obj && obj.constructor == Array);

        // fix.
        var self = arguments.callee;

        for (n in obj) {
            v = obj[n];
            t = typeof(v);
            if (obj.hasOwnProperty(n)) {
                if (t == "string") v = '"' + v + '"'; else if (t == "object" && v !== null)
                    // v = jQuery.stringify(v);
                    v = self(v);
                json.push((arr ? "" : '"' + n + '":') + String(v));
            }
        }
        return (arr ? "[" : "{") + String(json) + (arr ? "]" : "}");
    }
};

if(!String.prototype.trim) {
	  String.prototype.trim = function () {
	    return this.replace(/^\s+|\s+$/g,'');
	  };
}

/** 
 *所有浏览器支持的浏览器控制台输出信息的方法 
*/  
(function(){  
	if(!window.debug){  
  	window.debug = function(message){  
    	try{  
      	if( !window.console ){  
        	window.console = {};  
          window.console.log = function(){  
          	return arguments[0];  
          };
        }  
       	window.console.log(message + ' ');  
      } catch (e){}  
    };
	}  
})(); 

jQuery.prototype.serializeObject=function(){  
    var obj=new Object();  
    $.each(this.serializeArray(),function(index,param){  
        if(!(param.name in obj)){  
            obj[param.name]=param.value;  
        }  
    });  
    return obj;  
}; 

function closeWindow(){
	var userAgent = navigator.userAgent;
	if (userAgent.indexOf("Firefox") != -1 || userAgent.indexOf("Chrome") !=-1) {
	   window.location.href="about:blank";
	} else {
	   window.opener = null;
	   window.open("", "_self");
	   window.close();
	};
}



/**
 * cursorPosition Object
 *
 * Created by Blank Zheng on 2010/11/12.
 * Copyright (c) 2010 PlanABC.net. All rights reserved.
 * 
 * The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license.
 * 暂时没用到...
 */
 
var cursorPosition = {
	get: function (textarea) {
		var rangeData = {text: "", start: 0, end: 0 };
	
		if (textarea.setSelectionRange) { // W3C	
			//textarea.focus();
			rangeData.start= textarea.selectionStart;
			rangeData.end = textarea.selectionEnd;
			rangeData.text = (rangeData.start != rangeData.end) ? textarea.value.substring(rangeData.start, rangeData.end): "";
		} else if (document.selection) { // IE
			//textarea.focus();
			var i,
				oS = document.selection.createRange(),
				// Don't: oR = textarea.createTextRange()
				oR = document.body.createTextRange();
			oR.moveToElementText(textarea);
			
			rangeData.text = oS.text;
			rangeData.bookmark = oS.getBookmark();
			
			// object.moveStart(sUnit [, iCount]) 
			// Return Value: Integer that returns the number of units moved.
			for (i = 0; oR.compareEndPoints('StartToStart', oS) < 0 && oS.moveStart("character", -1) !== 0; i ++) {
				// Why? You can alert(textarea.value.length)
				if (textarea.value.charAt(i) == '\r' ) {
					i ++;
				}
			}
			rangeData.start = i;
			rangeData.end = rangeData.text.length + rangeData.start;
		}
		
		return rangeData;
	},
	
	set: function (textarea, rangeData) {
		var oR, start, end;
		if(!rangeData) {
			alert("You must get cursor position first.")
		}
		//textarea.focus();
		if (textarea.setSelectionRange) { // W3C
			textarea.setSelectionRange(rangeData.start, rangeData.end);
		} else if (textarea.createTextRange) { // IE
			oR = textarea.createTextRange();
			
			// Fixbug : ues moveToBookmark()
			// In IE, if cursor position at the end of textarea, the set function don't work
			if(textarea.value.length === rangeData.start) {
				//alert('hello')
				oR.collapse(false);
				oR.select();
			} else {
				oR.moveToBookmark(rangeData.bookmark);
				oR.select();
			}
		}
	},

	add: function (textarea, rangeData, text) {
		var oValue, nValue, oR, sR, nStart, nEnd, st;
		this.set(textarea, rangeData);
		
		if (textarea.setSelectionRange) { // W3C
			oValue = textarea.value;
			nValue = oValue.substring(0, rangeData.start) + text + oValue.substring(rangeData.end);
			nStart = nEnd = rangeData.start + text.length;
			st = textarea.scrollTop;
			textarea.value = nValue;
			// Fixbug:
			// After textarea.values = nValue, scrollTop value to 0
			if(textarea.scrollTop != st) {
				textarea.scrollTop = st;
			}
			textarea.setSelectionRange(nStart, nEnd);
		} else if (textarea.createTextRange) { // IE
			sR = document.selection.createRange();
			sR.text = text;
			sR.setEndPoint('StartToEnd', sR);
			sR.select();
		}
	}
}


function isIE(){
    return navigator.appName.indexOf("Microsoft Internet Explorer")!=-1 && document.all;
}