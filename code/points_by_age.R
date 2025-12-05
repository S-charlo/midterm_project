library(dplyr)
library(ggplot2)

here::i_am("code/points_by_age.R")
absolute_path_data <- here::here("raw_data/nba_2025-10-30")

# Load data
raw_data <- read.csv("raw_data/nba_2025-10-30") 

data <- raw_data |>
  filter(!is.na(Age), !is.na(FG), !is.na(X3P), !is.na(X2P), !is.na(FT),)

write.csv(data, "raw_data/nba_2025-10-30.csv", row.names = FALSE, na = "NA") 

# Points by Age
age_fg <-
ggplot(data, aes(x = Age, y = FG)) +
  geom_point() +
  labs(
    x = "Player Age",
    y = "Total Field Goals",
    title = "Scatterplot of Player Age by Total Field Goals"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_fg.png"),
  plot = age_fg,
  device = "png"
)

age_x3p <-
ggplot(data, aes(x = Age, y = X3P)) +
  geom_point() +
  labs(
    x = "Player Age",
    y = "Total Three Pointers",
    title = "Scatterplot of Player Age by Total Three Pointers"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_x3p.png"),
  plot = age_x3p,
  device = "png"
)

age_x2p <-
ggplot(data, aes(x = Age, y = X2P)) +
  geom_point() +
  labs(
    x = "Player Age",
    y = "Total Two Pointers",
    title = "Scatterplot of Player Age by Total Two Pointers"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_x2p.png"),
  plot = age_x2p,
  device = "png"
)
 
age_ft <-
ggplot(data, aes(x = Age, y = FT)) +
  geom_point() +
  labs(
    x = "Player Age",
    y = "Total Two Pointers",
    title = "Scatterplot of Player Age by Total Two Pointers"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_ft.png"),
  plot = age_ft,
  device = "png"
)

# Rank by Age
age_rank <-
ggplot(data, aes(x = Age, y = Rk)) +
  geom_point(alpha = 0.6) +     
  scale_y_reverse() + 
  labs(x = "Age", y = "Player Rank", title = "Player Rank by Age") +
  theme_minimal()


ggsave(
  here::here("output/figures/age_rank.png"),
  plot = age_rank,
  device = "png"
)


