library(tidyverse)

df <- read_csv("./final_data.csv")

df %>%
  filter(regiao == "America do Norte") %>%
  ggplot(aes(x=pais, y=r0, fill = tipo)) + geom_col(position = position_dodge()) + 
  theme_bw() -> g

g

df$regiao
reigoes <- unique(df$regiao)
colnames(reigoes)
