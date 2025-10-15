BackAlpha = 0;

DeathTextCount = real(text_get("text_you_died"));
DeathText = text_get($"text_you_died_{irandom_range(1, DeathTextCount)}");