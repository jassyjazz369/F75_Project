here::i_am(
  "code/odoba_weight.R"
) 

# Read in dataset
f75 <- read.csv(
  here::here("f75_interim.csv")
)

library(tidyverse)

# New dataset for weight analysis
f75_weight <- f75 %>%
  pivot_longer(cols = c(weight, weight1),
               names_to = "timepoint", values_to = "wt") %>%
  mutate(timepoint = factor(timepoint, levels = c("weight", "weight1"),
                            labels = c("Baseline", "Stabilization")))

# Save weight Dataset
saveRDS(f75_weight, here::here("f75_weight.RDS"))

# Bar plot looking at mean baseline weight pre and at stabilization
weight_bar <- ggplot(f75_weight, aes(x = arm, y = wt, fill = timepoint)) +
  geom_bar(stat = "summary", fun = "mean", position = "dodge") +
  labs(x = "Treatment arm", y = "Mean weight", fill = NULL,
title = "Mean weight at baseline and stabilization by Treatment arm") +
  theme_minimal(base_size = 13)

# Save plot
ggsave(here::here("output/weight_bar.png"), plot = weight_bar, width = 8, height = 5, units = "in")


# Line graph looking at mean baseline weight pre and at stabilization
weight_line <- ggplot(f75_weight, aes(x = timepoint, y = wt,
                                      color = arm, group = arm)) +
  stat_summary(fun = mean, geom = "line", linewidth = 1) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  labs(x = NULL, y = "Mean weight (kg)", color = "Treatment arm",
       title = "Mean weight at baseline and stabilization by Treatment arm") +
  theme_minimal(base_size = 13)

# Save plotme
ggsave(here::here("output/weight_line.png"), plot = weight_line, width = 8, height = 5, units = "in")
