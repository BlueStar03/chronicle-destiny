enum platform_type { error, desktop, mobile, web }

function Platform() constructor {
  type=platform_type.error
  color=c_fuchsia
  compiled=code_is_compiled()
  
  init=function(){
    if os_browser==browser_not_a_browser{
      switch(os_type){
        case os_windows: case os_linux: case os_macosx:
          type=platform_type.desktop; color=c_blue; break;
        case os_android: case os_ios:
          type=platform_type.mobile; color=c_red; break;
      }
    }else{
      type=platform_type.web;color=c_yellow;;
    }
  }
  
  toString =function (){
    switch (type) {
      case platform_type.desktop:  return "Desktop";
      case platform_type.mobile:  return "Mobile";
      case platform_type.web:  return"Web";
      default: return "ERROR";
    } 
  }
  init();  
}

