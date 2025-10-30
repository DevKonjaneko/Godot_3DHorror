shader_type spatial;
/**
CC0 (Public domain),
i mean, idc, really, let's be happy together

**/
/** CRT‑Main-Paramters **/
uniform vec2 resolution = vec2(320.0, 240.0);
uniform float pixel_size = 1.5;
uniform float scanline_strength = 0.2;
uniform float subpixel_strength = 0.6;
uniform float glow_intensity = 0.3;

/** Textur‑Parameters **/
uniform sampler2D albedo_texture : filter_nearest, source_color;
uniform vec2 tex_offset = vec2(0.0);
uniform vec2 tex_scale  = vec2(1.0);
uniform float tex_rotation_degrees = 0.0;

/** Rotation into Radians (internal conversion/translation) **/
vec2 rotate_uv(vec2 uv, float angle, vec2 pivot){
    float cos_a = cos(angle), sin_a = sin(angle);
    mat2 rot = mat2(vec2(cos_a, sin_a), vec2(-sin_a, cos_a));
    uv -= pivot; uv = rot * uv; uv += pivot;
    return uv;
}

void fragment() {
    vec2 uv = UV;
    vec2 pivot = vec2(0.5);

    float rad = radians(tex_rotation_degrees);
    uv = (uv - pivot) / tex_scale + pivot;
    uv = rotate_uv(uv, rad, pivot);
    uv += tex_offset;

    vec2 frag = uv * resolution;
    float scan = sin(frag.y * PI) * 0.5 + 0.5;
    scan = mix(1.0, scan, scanline_strength);
    float idx = mod(frag.x / pixel_size, 3.0);
    vec3 mask = vec3(
        float(idx < 1.0),
        float(idx >= 1.0 && idx < 2.0),
        float(idx >= 2.0)
    );
    mask = mix(vec3(1.0), mask, subpixel_strength);
    
    vec2 sample_uv = floor(uv * (resolution * 3.0)) / (resolution * 3.0);

    vec3 col = texture(albedo_texture, sample_uv).rgb;

    float vd = dot(NORMAL, -VIEW);
    float glow = pow(vd, 4.0) * glow_intensity;

    ALBEDO = col * scan * (1.0 - subpixel_strength);
    EMISSION = (col * mask * scan) + glow;
}