function Platform() constructor {
  type="ERROR"
  color=c_fuchsia
  compiled=code_is_compiled()
  
  init=function(){
    if os_browser==browser_not_a_browser{
      switch(os_type){
        case os_windows: case os_linux: case os_macosx:
          type="desktop"; color=c_blue; break;
        case os_android: case os_ios:
          type="mobile"; color=c_red; break;
      }
    }else{
      type="html5";color=c_yellow;;
    }
  } 
  toString =function (){
    return type;
  }
  init();  
}

