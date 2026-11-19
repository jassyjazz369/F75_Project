

library(tidyverse)
library(gtsummary)

sex_group <- "all"

# 1. Load and prepare data
f75 <- read.csv("data/f75_interim.csv")
f75 <- f75 |>
  filter(!is.na(arm)) |>
  mutate(arm = ifelse(grepl("Modified", arm), "Modified F75", "Standard F75"))
if (sex_group != "all") {
  f75 <- f75 |> filter(sex == sex_group)
}

# 2. Create output folders
dir.create("output/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("output/figures", recursive = TRUE, showWarnings = FALSE)

# 3. Table 1: age and sex by treatment arm
table1 <- f75 |>
  select(arm, agemons, sex) |>
  tbl_summary(by = arm) |>
  add_p()

saveRDS(table1, "output/tables/table1_demographics.rds")

# 4. Figure 1: age by treatment arm
figure1 <- ggplot(f75, aes(x = arm, y = agemons, fill = arm)) +
  geom_boxplot() +
  labs(x = "Treatment arm", y = "Age (months)")

ggsave("output/figures/figure1_age_by_arm.png",
       figure1, width = 9, height = 6, dpi = 300)
