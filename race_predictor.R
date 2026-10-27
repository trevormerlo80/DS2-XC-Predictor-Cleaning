#Galen Piper Results (2010-2026 x 17/20):
#Dickinson Long Short Results (,23-25)

library(tidyverse)
library(readr)
library(lubridate)


gp26 <- read_delim("gp26", delim = " ")

gp26_clean <- gp26 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = paste(str_extract_all(Team, "\\d+:\\d+.\\d+"), str_extract_all(Time, "\\d+:\\d+.\\d+"))) |> 
  mutate(Time = str_extract_all(Time, "\\d+:\\d+.\\d+")) |> 
  mutate(GP = period_to_seconds(ms(Time))) |> 
  select(Name, Time, GP)



gp25 <- read_delim("gp25", delim = " ")

gp25_clean <- gp25 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = str_extract_all(Time, "\\d+:\\d+.\\d+")) |> 
  select(Name, Time)


dls25 <- read_delim("dls25", delim = " ")

dls25_clean <- dls25 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = str_extract_all(Time, "\\d+:\\d+.\\d+")) |> 
  select(Name, Time)

join25 <- inner_join(gp25_clean, dls25_clean, by = "Name")




gp24 <- read_delim("gp24", delim = " ")

gp24_clean <- gp24 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = str_extract_all(Time, "\\d+:\\d+.\\d+")) |> 
  select(Name, Time)


dls24 <- read_delim("dls24", delim = " ")

dls24_clean <- dls24 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = str_extract_all(Time, "\\d+:\\d+.\\d+")) |> 
  select(Name, Time)

join24 <- inner_join(gp24_clean, dls24_clean, by = "Name")




gp23 <- read_delim("gp23", delim = " ")

gp23_clean <- gp23 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = paste(str_extract_all(Team, "\\d+:\\d+.\\d+"), str_extract_all(Time, "\\d+:\\d+.\\d+"))) |> 
  select(Name, Time)


dls23 <- read_delim("dls23", delim = " ")

dls23_clean <- dls23 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = paste(str_extract_all(Team, "\\d+:\\d+.\\d+"), str_extract_all(Time, "\\d+:\\d+.\\d+"))) |> 
  select(Name, Time)

join23 <- inner_join(gp23_clean, dls23_clean, by = "Name") |> 
  mutate(Time.x = str_extract_all(Time.x, "\\d+:\\d+.\\d+")) |> 
  mutate(Time.y = str_extract_all(Time.y, "\\d+:\\d+.\\d+"))

all_join <- rbind(join25, join24, join23)

all_join <- rbind(join25, join24, join23) |>
  mutate(GP = period_to_seconds(ms(Time.x)), DLS = period_to_seconds(ms(Time.y)))


all_join |> 
  ggplot(aes(GP, DLS)) + geom_point()




library("tidymodels");theme_set(theme_bw())


fit <- lm(DLS ~ GP, data = all_join)
summary(fit)

#-----------------------------C.Mbutha--K.Kabak.-T.Merlo--J.House--B.Hazel
predict(fit, data.frame(GP = c(1125.20, 1156.80, 1422.31, 1564.58, 1674.56)))

#T.Merlo
sprintf(
  "%d:%06.3f",
  floor(878.1298 / 60),
  878.1298 %% 60
)
#K.Kabak
sprintf(
  "%d:%06.3f",
  floor(726.3590    / 60),
  726.3590    %% 60
)




dls26 <- read_delim("dls26", delim = " ")

dls26_clean <- dls26 |> 
  mutate(Name = paste(First, Last)) |> 
  mutate(Time = paste(str_extract_all(Team, "\\d+:\\d+.\\d+"), str_extract_all(Time, "\\d+:\\d+.\\d+"))) |> 
  mutate(Time = str_extract_all(Time, "\\d+:\\d+.\\d+")) |> 
  mutate(DLS= period_to_seconds(ms(Time))) |> 
  select(Name, Time, DLS)



join26 <- inner_join(gp26_clean, dls26_clean, by = "Name") |> 
  mutate(Time.x = str_extract_all(Time.x, "\\d+:\\d+.\\d+")) |> 
  mutate(Time.y = str_extract_all(Time.y, "\\d+:\\d+.\\d+")) |> 
  mutate(Predicted = predict(fit, data.frame(GP = GP))) |> 
  mutate(Diff = Predicted - DLS)


join26 |> 
  ggplot(aes(Name, Diff)) + geom_point() + geom_hline(aes(yintercept = mean(Diff)), color = "blue") + 
  geom_hline(aes(yintercept = 0), color = "red") + theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1))

join26 |>
  ggplot(aes(reorder(Name, desc(Predicted)), Predicted)) + geom_point() +
  theme(axis.text.x = element_text(angle = 50, vjust = 1, hjust = 1)) +
  geom_point(aes(Name, DLS), color = "blue")


