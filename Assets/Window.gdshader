shader_type spatial;

uniform sampler2D albedo : source_color;
uniform float radius : hint_range(0.0, 1.0);

float circleShape(vec2 position) {
  // distance(p1, p2) - returns the distance between two points
  // https://thebookofshaders.com/glossary/?search=distance
  // always returns float
  float value = distance(position, vec2(0.5));
  // setp(edge, x) - compares two values
  // https://thebookofshaders.com/glossary/?search=step
  // edge - edge of step function
  // x - value used to generate step
  // x < edge
  // only retruns either 0.0 or 1.0    
  return step(radius, value);
}

void fragment() {
   //float alpha = 1.0 - smoothstep(radius - (radius * 0.01), radius + (radius * 0.01), dot(UV, UV) );
float circleWidth = 0.2;
  float circle = circleShape(UV);
	    ALBEDO = texture(albedo,UV).xyz;
		if(circle != 0.0){
			ALPHA = 0.0;
		}
	//ALPHA = alpha;
    // If the alpha channel is below a certain threshold, make it transparent
    //if (UV.x < 0.5) {
		//ALBEDO = texture(albedo,UV).xyz;
 //   }else{
	//	ALPHA = 0.0;
	//}
}
