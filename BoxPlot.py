import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler


# Load raw counts
counts_df = pd.read_csv("HP_counts.txt", sep="\t", index_col=0)  # Adjust filename

# Load DESeq2 results for first and last stage
de_results = pd.read_csv("DEseq_res_Gast_Met.csv", sep=",")  # Adjust filename

# Display the data
print("Counts Data:")
print(counts_df.head())

print("\nDESeq2 Results:")
print(de_results.head())


metadata = pd.read_csv("metadata_clean.txt", sep=",")  
metadata["Stage"] = metadata["library_name"].str.extract(r"([A-Za-z]+)")

bacterial_metadata = pd.read_csv("Data/raw/Genome-patient-list.txt", sep="\t", encoding="latin1")
print(bacterial_metadata["RNA seq ID"].unique())
bacterial_samples_list = bacterial_metadata["RNA seq ID"].unique()

valid_accessions = metadata[metadata["library_name"].isin(bacterial_samples_list)]["run_accession"].tolist()
filtered_counts_df = counts_df[valid_accessions]
filtered_counts_df.to_csv('HP_counts_fixed_163_bacterialsamples.txt', sep="\t")

#Boxplot
stages = ["Gast", "Atr", "EA", "Met"]
stage_samples = {
    "Gast": metadata[(metadata["library_name"].isin(bacterial_samples_list)) & 
                     (metadata["library_name"].str.startswith("Gast"))]["run_accession"],
    "Atr": metadata[(metadata["library_name"].isin(bacterial_samples_list)) & 
                    (metadata["library_name"].str.startswith("Atr"))]["run_accession"],
    "EA": metadata[(metadata["library_name"].isin(bacterial_samples_list)) & 
                   (metadata["library_name"].str.startswith("EA"))]["run_accession"],
    "Met": metadata[(metadata["library_name"].isin(bacterial_samples_list)) & 
                    (metadata["library_name"].str.startswith("Met"))]["run_accession"]
}

# Extract expression values for HP_1432
hp1432_expression = []
for stage, samples in stage_samples.items():
    num_samples = len(samples)  # Get the number of samples in each stage
    for sample in samples:
        if sample in filtered_counts_df.columns:  
            normalized_expression = filtered_counts_df.loc["HP_1432", sample] / num_samples
            hp1432_expression.append({"Stage": stage, "Expression": normalized_expression})

# Convert to DataFrame
expression_df = pd.DataFrame(hp1432_expression)

# Boxplot
plt.figure(figsize=(8,6))
sns.boxplot(data=expression_df, x="Stage", y="Expression", order=stages, palette="coolwarm", showmeans=True)
sns.stripplot(data=expression_df, x="Stage", y="Expression", order=stages, color="black", alpha=0.6, jitter=True)  # Add individual points
plt.xlabel("Stage")
plt.ylabel("Normalized Expression Count")
plt.title("Expression of HP_1432 Across Cancer Stages")
plt.grid(axis="y", linestyle="--", alpha=0.5)
plt.tight_layout()
plt.savefig("BoxPlot_HP1432.png")
plt.show()