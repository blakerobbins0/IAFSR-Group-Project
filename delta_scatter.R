library(ggplot2)

df <- read.csv("affective_ratings.csv")

# Correlation stats for annotation
cor_test <- cor.test(df$Delta_Pleasantness, df$Delta_Arousal)
r_val <- round(cor_test$estimate, 2)
p_val <- ifelse(cor_test$p.value < 0.001, "p < 0.001", paste0("p = ", round(cor_test$p.value, 3)))
label  <- paste0("r = ", r_val, ", ", p_val, "\nn = ", nrow(df))

ggplot(df, aes(x = Delta_Pleasantness, y = Delta_Arousal)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "gray60") +
  geom_vline(xintercept = 0, linetype = "dashed", color = "gray60") +
  geom_point(color = "#619CFF", alpha = 0.6, size = 2.2) +
  geom_smooth(method = "lm", color = "#F8766D", fill = "#F8766D", alpha = 0.15) +
  annotate("label", x = -Inf, y = Inf, hjust = -0.1, vjust = 1.2,
           label = label, size = 3.8, fill = "white", label.size = 0.3) +
  labs(
    title = "ΔPleasantness vs. ΔArousal",
    x     = "ΔPleasantness (Ultra-Processed − Unprocessed)",
    y     = "ΔArousal (Ultra-Processed − Unprocessed)"
  ) +
  theme_bw(base_size = 13) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

ggsave("delta_scatter.png", width = 7, height = 6, dpi = 150)


