here::i_am("code/player_eff.R")


library(dplyr)
library(ggplot2)
library(ggplot2)
library(here)


"READ csv"
nba <- read.csv(
  here::here("raw_data", "nba_2025-10-30.csv")
)
"********************************************************************************"



" Team-level shooting efficiency (attempts vs successful shots)"
team_eff <- nba |>
  group_by(Team) |>                              
  summarise(
    FG = sum(FG, na.rm = TRUE),     
    FGA = sum(FGA, na.rm = TRUE),
    .groups = "drop"
  ) |>
  mutate(
    ratio = FG / FGA,         # success ratio
    rank = dense_rank(desc(ratio))                  # 1 = highest ratio
  ) |>
  arrange(rank)                                     # sort by rank

team_eff_small <- team_eff |>
  select(Team, rank, ratio)


"***********************************************************************************"
"Calculate Player-level  shooting Efficiency"

player_eff <- nba %>%
  filter(FGA > 0) %>%                   
  mutate(ratio = FG / FGA) %>%
  arrange(desc(ratio)) %>%
  mutate(rank = row_number())

top_n_players <- 20

top_players <- player_eff %>%
  slice_head(n = top_n_players)



p_player_eff <- ggplot(
  top_players,
  aes(x = reorder(Player, ratio), y = ratio, fill = ratio)
) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(low = "#D6EAF8", high = "#2E86C1") +
  labs(
    title = "Top 20 Players by Shooting Efficiency",
    x = "Player",
    y = "Success Ratio",
    fill = "Ratio"
  )


" Player  impact score"
nba_impact <- nba %>%
  mutate(
    impact = PTS + TRB + AST + STL + BLK
  )


impact_rank <- nba_impact |>
  arrange(desc(impact)) |>
  mutate(rank = row_number())


top_impact <- impact_rank %>%
  slice_head(n = 15)

p_impact <- ggplot(
  top_impact,
  aes(x = reorder(Player, impact), y = impact, fill = impact)
) +
  geom_col() +
  coord_flip() +
  scale_fill_gradient(low = "#D5F5E3", high = "#27AE60") +
  labs(
    title = "Top 15 Players by Total Impact Score",
    x = "Player",
    y = "Impact Score",
    fill = "Impact"
  )

"To capture a more complete picture of player contribution, I expanded the Player Impact Score to include defensive components — specifically steals and blocks. These metrics reflect a player's ability to disrupt possessions and protect the rim, adding essential context beyond scoring and rebounding alone. By combining points, total rebounds, assists, steals, and blocks, the updated score highlights true two-way players whose impact goes beyond the basic box score. The resulting rankings reveal which athletes consistently influence the game across all phases, not just on the offensive end."


# Save clean objects


# Save team efficiency
saveRDS(
  team_eff,
  file = here::here("output", "team_eff.rds")
)

# Save player efficiency
saveRDS(
  player_eff,
  file = here::here("output", "player_eff.rds")
)

ggsave(
  filename = here::here("output", "top_players_eff.png"),
  plot     = p_player_eff,
  width    = 7,
  height   = 5,
  dpi      = 300
)

# Save impact rankings
saveRDS(
  impact_rank,
  file = here::here("output", "impact_rank.rds")
)

ggsave(
  filename = here::here("output", "top_players_impact.png"),
  plot     = p_impact,
  width    = 7,
  height   = 5,
  dpi      = 300
)
