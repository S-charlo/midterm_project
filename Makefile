


DATA = raw_data/nba_2025-10-30.csv

#continuous age scatter plots
output/figures/points_by_age.png: code/points_by_age.R $(DATA) | output/figures
	Rscript code/points_by_age.R

#categorical age bloxplots
output/figures/points_by_age_cat.png: code/points_by_age_cat.R $(DATA) | output/figures
	Rscript code/points_by_age_cat.R
	
#Age by rank scatterplot
output/figures/rank_by_age.png: code/rank_by_age.R $(DATA) | output/figures
	Rscript code/rank_by_age.R

# Player efficiency
output/figures/player_eff.png: code/player_eff.R $(DATA) | output/figures
	Rscript code/player_eff.R

#PHONY targets for each analysis part
.PHONY: points_cont points_cat rank efficiency

points_cont: output/figures/points_by_age.png

points_cat: output/figures/points_by_age_cat.png

rank: output/figures/rank_by_age.png

efficiency: output/figures/player_eff.png