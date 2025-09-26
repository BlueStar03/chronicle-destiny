function Data(reset = false) constructor {
  save_settings = function() {
      var settings_file = file_text_open_write("settings.sav");
      file_text_write_string(settings_file, json_stringify(settings));
      file_text_close(settings_file);
  };

  load_settings = function() {
      if (file_exists("settings.sav")) {
          var settings_file = file_text_open_read("settings.sav");
          var settings_data = file_text_read_string(settings_file);
          settings = json_parse(settings_data);
          file_text_close(settings_file);
      }
  };

  delete_all = function() {
      // Delete settings file
      if (file_exists("settings.sav")) {
          file_delete("settings.sav");
  }

  // Reset settings to default
  settings = {
      sys_display: {
          width: 640,
          height: 360,
          scale: 1,
          fullscreen: false
      },
      sys_input: {
          mode: input_modes.delay,
      },
      sys_dbug: {
          on: true,
          system: true,
          tracker: true,
          level: true,
          screen: true,
          build: true,
          controls: true,
          touch: true,
          collision: true,
      }
    };
  };

  init = function(reset) {
      if (reset) {
          delete_all();
          //save_settings();
      } else {
          load_settings();
      }
  };

  init(reset);
}
