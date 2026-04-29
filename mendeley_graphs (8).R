#| label: fig-upf-pleasantness
#| fig-cap: "Mean pleasantness ratings for ultra-processed food items, grouped by category."
#| fig-width: 16
#| fig-height: 6
#| warning: false

plot_bar(upf, "Pleasantness_Mean",
         "Pleasantness – Ultra-Processed Foods",
         "Mean Pleasantness", "#E07B54")



#| label: fig-upf-arousal
#| fig-cap: "Mean arousal ratings for ultra-processed food items, grouped by category."
#| fig-width: 16
#| fig-height: 6
#| warning: false

plot_bar(upf, "Arousal_Mean",
         "Arousal – Ultra-Processed Foods",
         "Mean Arousal", "#C0392B")






#| label: fig-umpf-pleasantness
#| fig-cap: "Mean pleasantness ratings for unprocessed/minimally processed food items, grouped by category."
#| fig-width: 16
#| fig-height: 6
#| warning: false

plot_bar(umpf, "Pleasantness_Mean",
         "Pleasantness – Unprocessed / Minimally Processed Foods",
         "Mean Pleasantness", "#5B9E6F")




#| label: fig-umpf-arousal
#| fig-cap: "Mean arousal ratings for unprocessed/minimally processed food items, grouped by category."
#| fig-width: 16
#| fig-height: 6
#| warning: false

plot_bar(umpf, "Arousal_Mean",
         "Arousal – Unprocessed / Minimally Processed Foods",
         "Mean Arousal", "#2471A3")