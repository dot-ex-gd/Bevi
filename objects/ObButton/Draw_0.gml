draw_set_font(Font);

draw_set_halign(fa_center);
draw_text(x, y, $"{(!Number) ? ">" : ""}{Text}{(!Number) ? "<" : ""}");
draw_set_halign(fa_left);