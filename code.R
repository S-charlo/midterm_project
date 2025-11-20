here::i_am("code")

"READ csv"
data <- read.csv("~/Data550/nba_2025-10-30")
write.csv(data, "nba_2025-10-30.csv", row.names = FALSE)
head(data)
"********************************************************************************"

library(dplyr)
library(ggplot2)

"Create team-level efficiency (attempts vs successful shots)"
team_eff <- data |>
  group_by(Team) |>                              # 1 row per team
  summarise(
    FG = sum(FG, na.rm = TRUE),     # total made shots
    FGA = sum(FGA, na.rm = TRUE)  # total attempts
  ) |>
  mutate(
    ratio = FG / FGA,         # success ratio
    rank = dense_rank(desc(ratio))                  # 1 = highest ratio
  ) |>
  arrange(rank)                                     # sort by rank

head(team_eff)

"***********************************************************************************"
"Calculate Player Efficiency"

player_eff <- data %>%
  filter(FGA > 0) %>%                     # avoids invalid  and division errors
  mutate(ratio = FG / FGA) %>%
  arrange(desc(ratio)) %>%
  mutate(rank = row_number())

top_players <- player_eff %>% slice_head(n = 20)

ggplot(top_players, aes(x = reorder(Player, ratio), y = ratio, fill = rank)) +
  geom_col() +
  coord_flip() +
  scale_fill_viridis_d() +                # FIXES WARNING #1
  labs(
    title = "Top 20 Players by Shooting Efficiency",
    x = "Player",
    y = "Success Ratio"
  )




" Players new rank based on success rates"
library(ggplot2)

top_players <- player_eff %>%
  slice_head(n = 20)

ggplot(top_players, aes(x = reorder(Player, ratio), y = ratio)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 20 Players by Shooting Efficiency",
    x = "Player",
    y = "Success Ratio (FG made / FG attempts)"
  )


"Fun little impact score"
data <- data %>%
  mutate(
    impact = PTS + TRB + AST + STL + BLK
  )


impact_rank <- data %>%
  arrange(desc(impact)) %>%
  mutate(rank = row_number())
head(impact_rank)


library(ggplot2)

top_impact <- impact_rank %>%
  slice_head(n = 15)

ggplot(top_impact, aes(x = reorder(Player, impact), y = impact, fill = rank)) +
  geom_col() +
  coord_flip() +
  scale_fill_viridis_c() +
  labs(
    title = "Top 15 Players by Total Impact Score",
    x = "Player",
    y = "Impact Score"
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

# Save impact rankings
saveRDS(
  impact_rank,
  file = here::here("output", "impact_rank.rds")
)
