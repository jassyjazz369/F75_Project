library(tidyverse)
library(gtsummary)

# Change this to "Male" or "Female" for the other two versions
sex_group <- "all"

f75 <- read.csv("data/f75_interim.csv")
f75 <- f75 |>
  filter(!is.na(arm)) |>
  mutate(arm = ifelse(grepl("Modified", arm), "Modified F75", "Standard F75"))
if (sex_group != "all") {
  f75 <- f75 |> filter(sex == sex_group)
}

# Table 1: age and sex by treatment arm
f75 |>
  select(arm, agemons, sex) |>
  tbl_summary(by = arm) |>
  add_p()

# Figure 1: age by treatment arm
ggplot(f75, aes(x = arm, y = agemons)) +
  geom_boxplot() +
  labs(x = "Treatment arm", y = "Age (months)")
