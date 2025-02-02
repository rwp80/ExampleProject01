shader_type spatial;
render_mode depth_draw_opaque, cull_back;

uniform sampler2D diffuse_texture : source_color, repeat_disable, filter_linear;
uniform sampler2D normal_map : hint_normal, repeat_disable, filter_linear;

void fragment() {
	vec2 wave = vec2(UV.x + 0.0625 * UV.y * sin(UV.y*PI*4.0+TIME), UV.y);
	vec4 diffuse = texture(diffuse_texture, wave);
	ALBEDO = diffuse.rgb;
	ALPHA = diffuse.a;
	NORMAL_MAP = texture(normal_map, wave).rgb;
	NORMAL_MAP_DEPTH = 2.0;
}
