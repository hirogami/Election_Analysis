library(tidycensus)
library(tidyverse)
census_api_key("b4be802992cf601bb2862e179f267a77dce93c82")
age10 <- get_decennial(geography = "state",
                       variables = "P013001",
                       year = 2010)

head(age10)
v17 <- load_variables(2017, "acs5", cache = TRUE)
vt <- get_acs(geography = "county",
              variables = c(medincome = " K200201"),
              state = "VT",
              year = 2018)

vars <- paste0("B01001_0", c(20:25, 44:49))

ramsey <- get_acs(geography = "tract",
                  variables = vars,
                  state = "MN",
                  county = "Ramsey",
                  year = 2016)

head(ramsey %>% select(-NAME))
la_age_hisp