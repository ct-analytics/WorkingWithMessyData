import pandas as pd
url = "https://data.cms.gov/data-api/v1/dataset/8889d81e-2ee7-448f-8713-f071038289b5/data?size=5000"
df = pd.read_json(url)
df.to_html()

cols = [0,12,19,20,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72]
df_subset = df.iloc[:,cols]

numeric_cols = df_subset.columns.drop(["Rndrng_NPI","Rndrng_Prvdr_Zip5"])
df_subset[numeric_cols]=df_subset[numeric_cols].apply(pd.to_numeric, errors='coerce')

categorical_cols = ["Rndrng_NPI","Rndrng_Prvdr_Zip5"]
df_subset[categorical_cols]=df_subset[categorical_cols].apply(pd.Categorical)


