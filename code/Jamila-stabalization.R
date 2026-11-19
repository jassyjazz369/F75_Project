
# ============================================================
# F75: Days to stabalization analysis
# How do children receiving standard F75 and modified F75
# differ in days to stabilization?
# Coder: Jamila Taffe
# ============================================================

library(readr)
library(dplyr)
library(ggplot2)

# 1. Load dataset
f75 <- read_csv("data/f75_interim.csv")

# 2. Prepare data
f75 <- f75 %>%
  mutate(
    arm = factor(
      arm,
      levels = c(
        "Standard F75",
        "Modified F75 (intervention)"
      ),
      labels = c(
        "Standard F75 (Control)",
        "Modified F75 (Treatment)"
      )
    )
  )

# 3. Create output folder
dir.create("output", showWarnings = FALSE)

# 4. Exclude 999 from actual stabilization-time analysis
stabilized <- f75 %>%
  filter(
    !is.na(days_stable),
    days_stable != 999
  )

# ============================================================
# FIGURE 1: BOXPLOT
# Days to stabilization by treatment arm
# ============================================================

figure1 <- ggplot(
  stabilized,
  aes(x = arm, y = days_stable, fill = arm)
) +
  geom_boxplot(
    alpha = 0.7,
    outlier.shape = NA
  ) +
  geom_jitter(
    width = 0.15,
    alpha = 0.3
  ) +
  labs(
    title = "Days to Stabilization by Treatment Arm",
    x = "Treatment Group",
    y = "Days to Stabilization"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(here::here("output/figures/figure1_boxplot.png"),
  figure1,
  width = 8,
  height = 6,
  dpi = 300
)

# ============================================================
# FIGURE 2: BAR CHART
# Mean days to stabilization by treatment arm
# ============================================================

summary_days <- stabilized %>%
  group_by(arm) %>%
  summarise(
    mean_days = mean(days_stable),
    sd_days = sd(days_stable),
    n = n(),
    .groups = "drop"
  )

figure2 <- ggplot(
  summary_days,
  aes(x = arm, y = mean_days, fill = arm)
) +
  geom_col(width = 0.6, alpha = 0.8) +
  geom_errorbar(
    aes(
      ymin = pmax(0, mean_days - sd_days),
      ymax = mean_days + sd_days
    ),
    width = 0.2
  ) +
  labs(
    title = "Average Days to Stabilization",
    subtitle = "Error bars represent standard deviation",
    x = "Treatment Group",
    y = "Mean Days to Stabilization"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

ggsave(here::here("output/figures/figure2_mean_days.png"),
  figure2,
  width = 8,
  height = 6,
  dpi = 300
)

# ============================================================
# FIGURE 3: GROUPED BAR CHART
# Percentage stabalized by Days 3 , 5 and 7 for each arm
# ============================================================
stabilization_days <- f75 %>%
  filter(!is.na(arm), !is.na(days_stable)) %>%
  group_by(arm) %>%
  summarise(
    Day_3 = mean(days_stable <= 3 & days_stable != 999) * 100,
    Day_5 = mean(days_stable <= 5 & days_stable != 999) * 100,
    Day_7 = mean(days_stable <= 7 & days_stable != 999) * 100
  )

# Create Figure 3
figure3 <- ggplot(
  data.frame(
    arm = rep(stabilization_days$arm, 3),
    Stabilization_Day = rep(c("Day 3", "Day 5", "Day 7"), each = nrow(stabilization_days)),
    Percentage = c(
      stabilization_days$Day_3,
      stabilization_days$Day_5,
      stabilization_days$Day_7
    )
  ),
  aes(x = Stabilization_Day, y = Percentage, fill = arm)
) +
  geom_col(position = "dodge") +
  labs(
    title = "Percentage of Children Stabilized by Day 3, 5, and 7",
    x = "Stabilization Day",
    y = "Percentage (%)",
    fill = "Treatment Group"
  ) +
  scale_y_continuous(limits = c(0, 100)) +
  theme_minimal()

# Save Figure 3
ggsave(here::here("output/figures/figure3_percentage_stabilized.png"),
       figure3, width = 9, height = 6, dpi = 300)

# ============================================================
# Display all 3 figures
# ============================================================

print(figure1)
print(figure2)
print(figure3)
