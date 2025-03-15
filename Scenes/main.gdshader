shader_type canvas_item;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

void fragment() {
    // Obtém a cor do pixel atual na textura
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Obtém a cor do pixel na tela
    vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
    
    // Verifica se o pixel atual é transparente (alpha = 0)
    if (tex_color.a > 0.0) {
        // Se não for transparente, aplica a inversão de cor
        COLOR = vec4(1.0 - screen_color.rgb, tex_color.a);
    } else {
        // Se for transparente, mantém transparente
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    }
}