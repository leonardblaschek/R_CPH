library(tidyverse)
library(randomizr)
set.seed(13)

runners <- read_tsv("/home/leonard/Dropbox/misc/relay.tsv", col_names = "name") |>  filter(name != "Leonard") |> slice(sample(1:n()))
walkers <- read_tsv("/home/leonard/Dropbox/misc/walk.tsv", col_names = "name") |> slice(sample(1:n()))

running <- complete_ra(
  N = 15,
  conditions = c("265", "266", "267")
) 

walking <- complete_ra(
  N = 13,
  conditions = c("7068", "7069", "7070")
)

runners <- add_column(runners, running) |> 
  arrange(running) |>
  group_by(running) |> 
  mutate(position = row_number())

walkers <- add_column(walkers, walking) |> 
  arrange(walking)

writexl::write_xlsx(list("runners" = runners,
                    "walkers" = walkers),
                    "/home/leonard/Dropbox/misc/relay.xlsx")

