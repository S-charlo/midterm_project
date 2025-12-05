library(dplyr)
library(ggplot2)

here::i_am("code/points_by_age.R")
absolute_path_data <- here::here("raw_data/nba_2025-10-30")

# Load data
raw_data <- read.csv("raw_data/nba_2025-10-30") 

data <- raw_data |>
  filter(!is.na(Age), !is.na(FG), !is.na(X3P), !is.na(X2P), !is.na(FT),)

write.csv(data, "raw_data/nba_2025-10-30.csv", row.names = FALSE, na = "NA") 

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