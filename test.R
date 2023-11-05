library(tidyverse)
library(jsonlite)
# https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider
url <- "https://data.cms.gov/data-api/v1/dataset/8889d81e-2ee7-448f-8713-f071038289b5/data?size=5000"

df <- fromJSON(url)

df

glimpse(df)

df.subset <- df |> 
    select(Rndrng_NPI,Rndrng_Prvdr_Zip5,Tot_Benes,Tot_Srvcs,starts_with("Bene_")) |>
    mutate(across(starts_with(c("Bene_","Tot_")), as.numeric),
                                 across(starts_with("Rndrng_"), factor))

skimr::skim(df.subset)

