ControlElementsEC = function()
{
    var fBlockId = 0x15;
    var instId = 0x03;
    
    this.ergoCmd1Slope =
    {
        funcId: 0x501,
        
        ErgoCmd1SlopeType:
        {
            N: 0,
            NO: 1,
            O: 2,
            SO: 3,
            S: 4,
            SW: 5,
            W: 6,
            NW: 7,
            Mitte: 15,
            Signalungueltig: 255
        },
    
        get: function() {
            console.log("getting ergoCmd1Slope");
        },
    
        set: function(val) {
            console.log("setting "+val+" on "+fBlockId);
//            $.post('/FBlock/'+fBlockId+'/'+instId+'/'+this.funcId, { value: val });
            console.log('/FBlock/'+fBlockId+'/'+instId+'/'+this.funcId);
        }
    };
    
    this.ergoCmd1Push =
    {
        funcId: 0x502,
        
        ErgoCmd1PushType:
        {
            KeineAktion: 0,
            Tasteistgedrueckt: 1,
            Reserviert: 2,
            Signalungueltig: 3
        },
        
        get: function()
        {
            console.log("getting ergoCmd1Push")
        },
        
        set: function(val)
        {
            console.log("setting");
            $.post('/FBlock/'+fBlockId+'/'+instId+'/'+this.funcId, { value: val });
        }
    }
}

var controlElementsEC = new ControlElementsEC();

controlElementsEC.ergoCmd1Slope.set(5);
controlElementsEC.ergoCmd1Slope.get();
console.log(controlElementsEC.ergoCmd1Slope.ErgoCmd1SlopeType.NO);

//function ControlElementsEC()
//{
//    console.log("constructor");
//
//    this.nested = {
//      publicNestedMethod: function() {
//        console.log("publicNestedMethod");
//      }
//    };
//}
//
//ControlElementsEC.fBlockId = 0x15;
//ControlElementsEC.instId = 0x03;
//
//ControlElementsEC.prototype.ergoCmd1Slope = function()
//{
//    console.log("ergoCmd1Slope");
//    
//    this.set = function (a) {
//        console.log("set "+a);
//    };
//}
//    var funcId = 0x501;
//    
//    this.ErgoCmd1SlopeType =
//    {
//        N: 0,
//        NO: 1,
//        O: 2,
//        SO: 3,
//        S: 4,
//        SW: 5,
//        W: 6,
//        NW: 7,
//        Mitte: 15,
//        Signalungueltig: 255
//    };
//
//    var _ergoCmd1Slope = this.ErgoCmd1SlopeType.Mitte;
//    
//    this.set = function(value) {
//        _ergoCmd1Slope = value;
//    }
//    
//    this.get = function(value) {
//        return _ergoCmd1Slope;
//    }
//}
//
//ControlElementsEC.prototype.ergoCmd1Push = function()
//{
//    var funcId = 0x502;
//    console.log(this.fBlockId);
//    
//    this.ErgoCmd1PushType = 
//    {
//        KeineAktion: 0,
//        Tasteistgedrueckt: 1,
//        Reserviert: 2,
//        Signalungueltig: 3
//    };
//
//    var _ergoCmd1Push = this.ErgoCmd1PushType.Signalungueltig;
//    
//    this.set = function(value) {
//        console.log(ControlElementsEC.fBlockId);
//        console.log(this.fBlockId);
//        console.log(funcId);
//        _ergoCmd1Push = value;
//    }
//
//    this.get = function(value) {
//        return _ergoCmd1Push;
//    }
//}

//$(function() {
//  var controlElementsEC = new ControlElementsEC();
//  console.log(ControlElementsEC.fBlockId);
//  ControlElementsEC.nested.publicNestedMethod();
//  console.log($.controlElementsEC.fBlockId);
//  $.controlElementsEC.ergoCmd1Slope.set($.controlElementsEC.ergoCmd1Slope.ErgoCmd1SlopeType.NW);
//  $.controlElementsEC.ergoCmd1Slope.set(7);
//  console.log("ergoCmd1Slope", $.controlElementsEC.ergoCmd1Slope.get());
//  console.log("ergoCmd1Push", $.controlElementsEC.ergoCmd1Push.get());
//  
//  $('#push_center').mousedown(function() {
//    console.log("down");
//    $.controlElementsEC.ergoCmd1Push.set($.controlElementsEC.ergoCmd1Push.ErgoCmd1PushType.Tasteistgedrueckt);
//  });
//  $('#push_center').mouseup(function() {
//    console.log("up");
//    $.controlElementsEC.ergoCmd1Push.set($.controlElementsEC.ergoCmd1Push.ErgoCmd1PushType.KeineAktion);
//  });
//});

/*
CErgoCmd1Slope.prototype.setErgoCmd1Slope function (val) {
    $.post("/FBlock/0x15/0x03/0x501", { value: val } );
}
*/