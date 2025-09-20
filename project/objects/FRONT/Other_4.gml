var a = layer_get_all();
for (var i = 0; i < array_length(a); i++;)
{
  if layer_tilemap_get_id(a[i]) != -1
    layer_set_visible(a[i],false)
}