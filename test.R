
## read in data
library(tidyverse)
library(jsonlite)

# Practioner data from:
# https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider
url <- "https://data.cms.gov/data-api/v1/dataset/8889d81e-2ee7-448f-8713-f071038289b5/data?size=5000"

df <- fromJSON(url)

## EDA 

skimr::skim(df)

## Changing data types

df.subset <- df |> 
    select(Rndrng_NPI,Rndrng_Prvdr_Zip5,Tot_Benes,Tot_Srvcs,starts_with("Bene_")) |>
    mutate(across(starts_with(c("Bene_","Tot_")), as.numeric),
                                 across(starts_with("Rndrng_"), factor))

skimr::skim(df.subset)

library(ggExtra)
library(ggplot2)
library(scales)

g <- ggplot(df.subset, aes(x=Bene_Feml_Cnt, y=Bene_Male_Cnt)) + 
    geom_point() +
    theme(legend.position="none") +
    labs(x="Total Beneficiaries",
         y="Total Services") +
    scale_x_continuous(labels=label_number(scale_cut = cut_short_scale())) +
    scale_y_continuous(labels=label_number(scale_cut = cut_short_scale())) +
    ggthemes::theme_hc()

ggMarginal(g, type="histogram")

## Missing data

### MICE

library(mice)
md.pattern(df.subset)

imp <- df.subset |>
    mice(maxit=10, seed=42)





