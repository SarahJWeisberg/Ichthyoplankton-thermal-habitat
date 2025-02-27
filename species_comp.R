library(readr)
library(dplyr)
Barcoding_Results_Full <- read_csv("data/Barcoding_Results_Full.csv")
nyos_unique_spp <- Barcoding_Results_Full %>% 
  dplyr::select(`Genus species`) %>%
  dplyr::distinct()

lewis <- readxl::read_excel("data/FishEggDatabase_GenID.accdb.xls", sheet = "EggIDData")

lewis_unique_spp <- lewis %>% 
  dplyr::select(Genus, Species) %>%
  dplyr::filter(!(is.na(Genus)))

lewis_unique_spp$Species <- gsub("^.*\\.","", lewis_unique_spp$Species)

lewis_unique_spp <- lewis_unique_spp %>%
  dplyr::mutate(Genus_species = paste(Genus, Species, sep = "")) %>%
  dplyr::distinct()

diff <- nyos_unique_spp %>%
  dplyr::filter(!`Genus species` %in% lewis_unique_spp$Genus_species)
