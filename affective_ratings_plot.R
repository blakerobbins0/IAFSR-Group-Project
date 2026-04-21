library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("affective_ratings.csv")

# Reshape to long format and compute mean ± 95% CI per condition × dimension
summary_df <- df %>%
  select(
    Unprocessed_Pleasantness   = Unprocessed_Pleasantness_Mean,
    Unprocessed_Arousal        = Unprocessed_Arousal_Mean,
    UltraProcessed_Pleasantness = UltraProcessed_Pleasantness_Mean,
    UltraProcessed_Arousal     = UltraProcessed_Arousal_Mean
  ) %>%
  pivot_longer(everything(), names_to = "condition", values_to = "rating") %>%
  separate(condition, into = c("FoodType", "Dimension"), sep = "_") %>%
  mutate(FoodType = recode(FoodType, UltraProcessed = "Ultra-Processed")) %>%
  group_by(FoodType, Dimension) %>%
  summarise(
    Mean = mean(rating, na.rm = TRUE),
    SE   = sd(rating, na.rm = TRUE) / sqrt(n()),
    .groups = "drop"
  ) %>%
  mutate(
    CI_low  = Mean - 1.96 * SE,
    CI_high = Mean + 1.96 * SE
  )

# Plot
ggplot(summary_df, aes(x = Dimension, y = Mean, fill = FoodType)) +
  geom_col(position = position_dodge(width = 0.7), width = 0.6, alpha = 0.9) +
  geom_errorbar(
    aes(ymin = CI_low, ymax = CI_high),
    position = position_dodge(width = 0.7),
    width = 0.2, linewidth = 0.7
  ) +
  scale_fill_manual(values = c("Unprocessed" = "#619CFF", "Ultra-Processed" = "#F8766D")) +
  labs(
    title = "Affective Ratings by Food Processing Level",
    x     = NULL,
    y     = "Mean Rating (± 95% CI)",
    fill  = "Food Type"
  ) +
  theme_bw(base_size = 13) +
  theme(
    plot.title       = element_text(face = "bold", hjust = 0.5),
    panel.grid.major.x = element_blank(),
    legend.position  = "right"
  )

ggsave("affective_ratings_paired_bar.png", width = 7, height = 5, dpi = 150)
