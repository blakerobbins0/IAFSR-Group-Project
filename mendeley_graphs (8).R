# ─────────────────────────────────────────────────────────────────────────────
# Mendeley Dataset – Affective Ratings, 4 graphs with category facets (Vertical)
# ─────────────────────────────────────────────────────────────────────────────

library(readxl)
library(ggplot2)
library(dplyr)

# ── 1. Load data ──────────────────────────────────────────────────────────────

file_path <- "C:/Users/laure/Downloads/Mendeley_dataset_table_1.xlsx"

col_names <- c("Item", "Pleasantness_Mean", "Pleasantness_SD", "Arousal_Mean", "Arousal_SD")

upf <- read_excel(file_path, sheet = "Table1b_UltraProcessed",
                  skip = 2, col_names = col_names) %>%
  mutate(
    Pleasantness_Mean = as.numeric(Pleasantness_Mean),
    Arousal_Mean      = as.numeric(Arousal_Mean),
    Category = case_when(
      Item %in% c("nugget", "bacon", "sausage", "hot dog",
                  "cooked pork salami")                          ~ "Meat & Protein",
      Item %in% c("potato chips", "tortilla chips", "starch chips",
                  "microwave popcorn", "corn chips")             ~ "Snacks & Chips",
      Item %in% c("chocolate bar", "gums", "ice cream",
                  "chocolate-covered marshmallow", "popsicle",
                  "jelly", "cookie", "cookie stuffed with chocolate",
                  "cookie stuffed with vanilla", "chocolate discs",
                  "wafer cookies")                               ~ "Sweets & Confectionery",
      Item %in% c("ready-to-eat pizza", "hamburguer",
                  "ready-to-eat lasagna", "instant noodles")     ~ "Fast Food & Meals",
      Item %in% c("breakfast cereals", "brazilian cheese bread",
                  "panettone with milk jam cream")               ~ "Bread & Cereals",
      Item %in% c("grape soda", "ready-to-drink chocolate milk",
                  "coke soda")                                   ~ "Beverages",
      TRUE                                                       ~ "Other"
    )
  ) %>%
  mutate(Category = factor(Category, levels = c(
    "Meat & Protein", "Fast Food & Meals", "Snacks & Chips",
    "Sweets & Confectionery", "Bread & Cereals", "Beverages", "Other"
  )),
  Item = reorder(Item, as.numeric(Category) * 100 + rank(Item)))

umpf <- read_excel(file_path, sheet = "Table1c_UnprocessedFood",
                   skip = 2, col_names = col_names) %>%
  mutate(
    Pleasantness_Mean = as.numeric(Pleasantness_Mean),
    Arousal_Mean      = as.numeric(Arousal_Mean),
    Category = case_when(
      Item %in% c("watermelon", "apple", "kiwi", "strawberry", "grape",
                  "papaya", "pineapple*", "pear", "mango", "apricot",
                  "orange", "peach", "banana")                   ~ "Fruit",
      Item %in% c("salad", "salad*", "lettuce", "cherry tomato",
                  "broccoli", "potato", "string beans", "carrot",
                  "kale", "corn")                                ~ "Vegetables",
      Item %in% c("beef", "salmon", "egg")                      ~ "Meat, Fish & Eggs",
      Item %in% c("cashew nut", "bean")                         ~ "Nuts & Legumes",
      Item %in% c("tapioca", "brazilian lunch")                  ~ "Grains & Meals",
      Item %in% c("mandarin juice", "coconut water")             ~ "Beverages",
      TRUE                                                       ~ "Other"
    )
  ) %>%
  mutate(Category = factor(Category, levels = c(
    "Meat, Fish & Eggs", "Fruit", "Vegetables",
    "Nuts & Legumes", "Grains & Meals", "Beverages", "Other"
  )),
  Item = reorder(Item, as.numeric(Category) * 100 + rank(Item)))

# ── 2. Shared theme ───────────────────────────────────────────────────────────

bar_theme <- theme_minimal(base_size = 11) +
  theme(
    plot.title         = element_text(face = "bold", size = 14, hjust = 0.5),
    axis.title.y       = element_text(margin = margin(r = 8)),
    axis.text.x        = element_text(angle = 45, hjust = 1, size = 9),
    panel.grid.major.x = element_blank(),
    panel.grid.minor   = element_blank(),
    panel.grid.major.y = element_line(color = "grey88"),
    strip.text         = element_text(face = "bold", size = 10),
    strip.background   = element_rect(fill = "grey92", color = NA),
    plot.margin        = margin(12, 18, 12, 12)
  )

# ── 3. Plotting function ──────────────────────────────────────────────────────

plot_bar <- function(data, mean_col, title, y_label, fill_color) {
  ggplot(data, aes(x = Item, y = .data[[mean_col]])) +
    geom_col(fill = fill_color, width = 0.65, alpha = 0.88) +
    facet_wrap(~ Category, scales = "free_x", nrow = 1) +
    labs(title = title, y = y_label, x = NULL) +
    bar_theme
}

# ── 4. Build the 4 graphs ─────────────────────────────────────────────────────

p1 <- plot_bar(upf,  "Pleasantness_Mean",
               "Pleasantness – Ultra-Processed Foods",
               "Mean Pleasantness", "#E07B54")

p2 <- plot_bar(upf,  "Arousal_Mean",
               "Arousal – Ultra-Processed Foods",
               "Mean Arousal", "#C0392B")

p3 <- plot_bar(umpf, "Pleasantness_Mean",
               "Pleasantness – Unprocessed / Minimally Processed Foods",
               "Mean Pleasantness", "#5B9E6F")

p4 <- plot_bar(umpf, "Arousal_Mean",
               "Arousal – Unprocessed / Minimally Processed Foods",
               "Mean Arousal", "#2471A3")

# ── 5. Print graphs ───────────────────────────────────────────────────────────

print(p1)
print(p2)
print(p3)
print(p4)

# ── 6. Optional: save as PNG ──────────────────────────────────────────────────

# ggsave("p1_UPF_Pleasantness.png",  plot = p1, width = 16, height = 6, dpi = 300)
# ggsave("p2_UPF_Arousal.png",       plot = p2, width = 16, height = 6, dpi = 300)
# ggsave("p3_UMPF_Pleasantness.png", plot = p3, width = 16, height = 6, dpi = 300)
# ggsave("p4_UMPF_Arousal.png",      plot = p4, width = 16, height = 6, dpi = 300)
