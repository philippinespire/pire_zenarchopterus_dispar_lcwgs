#setting the stage
setwd('/home/tburris/TGA/')

#loading packages
install.packages("tidyverse")
library(tidyselect)

ggplot(data = e, aes(x = PC1, y = PC2, color = Era, shape = Location)) +
  geom_point(size = 4, alpha = 0.4) +
  scale_color_manual(
    values = c("#00BFC4", "#F8766D"),
    labels = c("Contemporary", "Historical")
  ) +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.text.y = element_blank()
  ) +
  xlab(paste0("PC", x_axis, " (", round(x_variance, 2), "%)")) +
  ylab(paste0("PC", y_axis, " (", round(y_variance, 2), "%)")) +
  labs(color = "Era", shape = "Location")

