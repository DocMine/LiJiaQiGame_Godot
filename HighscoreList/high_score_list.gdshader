shader_type canvas_item;

//uniform vec4 flashColor:hint_color = vec4(1.0);
uniform vec4 flashColor: source_color = vec4(1.0);
uniform float flashModifier: hint_range(0.0, 1.0, 0.1) = 1;

void fragment() {
	// Place fragment code here.
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, flashColor.rgb, flashModifier);
	COLOR = color;
	COLOR = vec4(COLOR.r, COLOR.g, COLOR.b, COLOR.b+COLOR.r-COLOR.g);
	vec2 uv = UV;
	uv.x += 0.1;
	//COLOR = texture(TEXTURE, uv);
}
