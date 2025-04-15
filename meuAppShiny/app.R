#pacotes
library(dplyr)
library(readr)
library(ggplot2)
library(shiny)
library(tidyr)

#-------- Dados -------
dados <- read.csv("final_data.csv", stringsAsFactors = FALSE)
colnames(dados)

#-------- UI ----------

