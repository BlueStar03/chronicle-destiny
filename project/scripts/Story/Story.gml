enum think_states { st1,st2,st3,st4,st5 }


//*******************************************************************************************************


function Dialog() constructor {


  think=new Think();
  speak=new Speak();
  listen=new Listen();
  
  
  player_character=noone;
  set_player_character=function(id){
    player_character=id
  }
  
  update=function(){
  if player_character!=noone{
        think.update();
    }

  } 
 
  draw=function(){
    if player_character!=noone{
      think.draw();
      speak.draw();
      listen.draw();

    }   
  }
}

//**************************************************************************

function Think() constructor {
  on=false;
  timer=0;
  
  update=function(){
    //if INPUT.dialog{on=true;}
    //if on{
      //if !INPUT.dialog{
        //speak.on=true
        //on=false
      //}
    //}
  }  
 
  draw=function(){
    if on {
        var radius=128;
        var center_x=SCREEN.center.x;
        var center_y=SCREEN.center.y;
        var count = 3
        var step=360/count;
        var start=90;
  
        for (var i=0; i<count;i++){
          var ang=start+i*step;
          var px=center_x+lengthdir_x(radius,ang)
          var py=center_y+lengthdir_y(radius,ang)
          draw_sprite(spr_dialog,i,px,py);
        }
    } 
    draw_text_outline(10,20,timer)
  }
}

/// ************************************************************************
function Speak() constructor {
  on=false;
  update=function(){
    
  }  
 
  draw=function(){
    if on{
      draw_dialogbox("player")
    }
  } 
}

//**************************************************************************

function Listen() constructor {
  on=false;
  update=function(){
    
  }  
 
  draw=function(){
    if on{
      draw_dialogbox("npc")
    }
  } 
}

//*********************************************************
//********************************************************


function Story() constructor {
  player_character=noone;

  
  dialog=new Dialog()
  
  set_player_character=function(id){
    player_character=id
    dialog.set_player_character(player_character)
  }
 
  update=function(){
      dialog.update()
  }  
 
  draw=function(){
    dialog.draw()
  }   
  
  draws=function(){
    gpu_set_depth(-1);
    draw_sprite(Sprite3,0,100,100);
    draw_circle(100,100,50,false);
    draw_text(100,100,"hello,World!");
    
  }
  
}


/*
function Dialog() constructor {
        // State flags
    think    = false; // player can choose dialog options
    reply    = false; // player is talking
    response = false; // NPC is talking
    in_convo = false; // in a conversation at all
    
    // Conversation target
    convo_with = noone; // NPC instance ID

  
  dialog_set = [
    ["greet",    "Hello!", "Hi!"],
    ["order",    "Hey you"],
    ["question", "I have a question", "So..."]
];
  
  
  
  update=function(){
    if keyboard_check(ord("J")){
      think=true;
    }else{
      think=false;
    }
    
  }
    index=0;
  update_think=function(){
    static silence=false;
    static count=2;
    
    count=array_length(dialog_set)
    var index_rotate=keyboard_check_pressed(ord("Q"))-keyboard_check_pressed(ord("E"))
    index+=index_rotate
    
  }
  
  
  
  
  // ---- Draw dispatch ----
    draw = function() {

        if (think)    draw_think();
        if (reply)    draw_reply();
        if (response) draw_response();
          
      
    };

    // ---- Sub-draws (stubs) ----
    draw_think = function() {
      var radius=128;
      var center_x=display.width/2;
      var center_y=display.height/2
      var count = 3
      var step=360/count;
      var start=90;

      for (var i=0; i<count;i++){
        var ang=start+i*step;
        var px=center_x+lengthdir_x(radius,ang)
        var py=center_y+lengthdir_y(radius,ang)
        draw_sprite(spr_dialog,i,px,py);
      }
    };

    draw_reply = function() {
        // TODO: draw player's speaking line
    };

    draw_response = function() {
        // TODO: draw NPC's speaking line
    };
  
  
}
}*/