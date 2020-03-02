shader_type canvas_item;
render_mode blend_add;

uniform float seed = 0.0;
uniform float speed = 2.0;
uniform vec2 amplitude = vec2(2.0,2.0);
uniform float flicker_strength = 0.1;
uniform float flicker_speed = 3.0;
uniform vec3 color = vec3 (1.0, 1.0, 0.5);


void vertex() {
	VERTEX.x += ( cos((TIME + seed) * speed + VERTEX.x ) + sin((TIME + seed) * speed * 0.5) ) * amplitude.x;
	VERTEX.y += ( sin((TIME + seed) * speed + VERTEX.y ) * cos((TIME + seed) * speed * 0.5) ) * amplitude.y;
}

void fragment(){
	
	float alpha_glow = (1.0 - pow( length( UV / 0.5 - 1.0 ), 0.3)) * 0.5;
	float alpha_glow_clamped = max(alpha_glow, 0.0);
	
	float inner_circle = 1.0 - pow( length( UV / 0.5 - 1.0), 6.0) * 1000.0;
	float inner_circle_clamped = max(inner_circle, 0.0);
	
	float circle_alpha =  max(alpha_glow_clamped, inner_circle_clamped);
	float circle_alpha_animated =  circle_alpha - circle_alpha * flicker_strength * abs( cos((TIME + seed) * flicker_speed) );
	vec3 circle_color = color + 0.1 * inner_circle_clamped;
	
	COLOR = vec4(circle_color, circle_alpha_animated);
}