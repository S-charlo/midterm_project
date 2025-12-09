here::i_am("code/points_by_age.R")

library(dplyr)
library(ggplot2)
library(here)

# Load data
raw_data <- read.csv(here::here("raw_data", "nba_2025-10-30.csv"))

data <- raw_data |>
  filter(!is.na(Age), !is.na(FG), !is.na(X3P), !is.na(X2P), !is.na(FT)) |>
  mutate(
    age_band =cut(
      Age,
      breaks = c(18, 23, 28, 33, 38, 43),
      labels = c("18–22", "23–27", "28–32", "33–37", "38–42"),
      right = FALSE,
      include.lowest = TRUE
    )
  )

#FG
age_cat_fg <- ggplot(data, aes(x = age_band, y = FG)) +
  geom_boxplot() +
  labs(
    x = "Age Band",
    y = "Total Field Goals",
    title = "Distribution of Field Goals by Age Bands"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_cat_fg.png"),
  plot = age_cat_fg,
  device = "png"
)

#X3P
age_cat_x3p <- ggplot(data, aes(x = age_band, y = X3P)) +
  geom_boxplot() +
  labs(
    x = "Age Band",
    y = "Total Three Pointers",
    title = "Distribution of Three Pointers by Age Bands"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_cat_x3p.png"),
  plot = age_cat_x3p,
  device = "png"
)

#X2P
age_cat_x2p <- ggplot(data, aes(x = age_band, y = X2P)) +
  geom_boxplot() +
  labs(
    x = "Age Band",
    y = "Total Two Pointers",
    title = "Distribution of Two Pointers by Age Bands"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_cat_x2p.png"),
  plot = age_cat_x2p,
  device = "png"
)

#FT
age_cat_ft <- ggplot(data, aes(x = age_band, y = FT)) +
  geom_boxplot() +
  labs(
    x = "Age Band",
    y = "Total Free Throws",
    title = "Distribution of Free Throws by Age Bands"
  ) +
  theme_minimal()

ggsave(
  here::here("output/figures/age_cat_ft.png"),
  plot = age_cat_ft,
  device = "png"
)
