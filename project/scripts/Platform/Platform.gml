enum platform_type { ERROR, DESKTOP, MOBILE, HTML5 }

function Platform() constructor {
  type=platform_type.ERROR
  color=c_fuchsia
  compiled=code_is_compiled()
  
  init=function(){
    if os_browser==browser_not_a_browser{
      switch(os_type){
        case os_windows: case os_linux: case os_macosx:
          type=platform_type.DESKTOP; color=c_blue; break;
        case os_android: case os_ios:
          type=platform_type.MOBILE; color=c_red; break;
      }
    }else{
      type=platform_type.HTML5;color=c_yellow;;
    }
  } 
  
    is_desktop = function() { return type == platform_type.DESKTOP; };
    is_mobile  = function() { return type == platform_type.MOBILE;  };
    is_web     = function() { return type == platform_type.HTML5;   };
    is_YYC     = function() { return compiled; };
  
  toString =function (){
    var _s="ERROR"
    switch (type) {
      case platform_type.DESKTOP:  _s="Desktop"; break;
      case platform_type.HTML5:  _s="Web"; break;
      case platform_type.MOBILE:  _s="Mobile"; break;
      default: _s="ERROR"; break;
    } 
    return _s;
  }
  init();  
}

