.PHONY: init install testing_rule report.html

# Initialize renv in the project 
init:
	Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::init()"

# Render Report
midterm.html: midterm.Rmd code/points_by_age.R code/rank_by_age.R
	Rscript code/02_render_report.R

# Restore Package Library
install:
	Rscript -e "renv::restore(prompt = FALSE)"

# Test with rows removed
testing_rule:
	Rscript -e "message('Testing report build with rows removed'); \
	            df <- read.csv('raw_data/nba_2025-10-30'); \
	            df_subset <- df[1:floor(nrow(df)/2), ]; \
	            write.csv(df_subset, 'raw_data/temp_subset.csv', row.names = FALSE); \
	            rmarkdown::render('midterm.Rmd', quiet = TRUE, params = list(data_file = 'raw_data/temp_subset.csv'))"
	Rscript -e "message('Testing report build with fake rows'); \
	            df <- read.csv('raw_data/nba_2025-10-30'); \
	            df_extra <- rbind(df, df[sample(nrow(df), 20, replace = TRUE), ]); \
	            write.csv(df_extra, 'raw_data/temp_extra.csv', row.names = FALSE); \
	            rmarkdown::render('midterm.Rmd', quiet = TRUE, params = list(data_file = 'raw_data/temp_extra.csv'))"
	Rscript -e "message('All tests completed successfully.')"