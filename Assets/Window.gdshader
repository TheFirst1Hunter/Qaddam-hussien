shader_type spatial;

uniform sampler2D albedo : source_color;
uniform float radius : hint_range(0.0, 1.0);

void fragment() {
   float alpha = 1.0 - smoothstep(radius - (radius * 0.01), radius + (radius * 0.01), dot(UV, UV) );

    ALBEDO = texture(albedo,UV).xyz;
	ALPHA = alpha;
    // If the alpha channel is below a certain threshold, make it transparent
    //if (UV.x < 0.5) {
		//ALBEDO = texture(albedo,UV).xyz;
 //   }else{
	//	ALPHA = 0.0;
	//}
}
